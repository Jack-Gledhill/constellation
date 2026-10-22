# Traefik

[Traefik](https://traefik.io) is the cluster's ingress controller, handling all external traffic and routing it to the appropriate services.
This integrates nicely with [MetalLB](https://metallb.io) and [Cert Manager](https://cert-manager.io), with the former providing High Availability to Traefik, and the latter ensuring routes are properly secured with valid SSL certificates.

## Middleware

Middleware can be declared and used anywhere in the cluster.
Several middlewares are defined by default in the [`middleware`](/traefik/middleware) directory, providing a number of common functions that you'd expect to see in a homelab.

| Middleware                                                                                                  | Manifest                                                     | Description                                                                                                                                                                                                                      |
|-------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [BasicAuth](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/basicauth/)     | [`basic-auth.yml`](/traefik/middleware/basic-auth.yml)       | Secures any route with the Basic Auth method, using a set of credentials defined in [`credentials.basic-auth.yml`](/traefik/middleware/credentials.basic-auth.yml)                                                               |
| [Headers](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/headers/)         | [`cors.yml`](/traefik/middleware/cors.yml)                   | Adds a number of headers to the route's responses. This configures [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CORS) to permit cross-origin requests from a number of predefined origins.                    |
| [ForwardAuth](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/forwardauth/) | [`forward-auth.yml`](/traefik/middleware/forward-auth.yml)   | Use on a route to require users to login with Authelia before access to the route is permitted. Uses the [Forward Auth](https://docs.goauthentik.io/add-secure-apps/providers/proxy/forward_auth/) method to authenticate users. |
| [IPAllowList](https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/ipallowlist/) | [`intranet-only.yml`](/traefik/middleware/intranet-only.yml) | Refuses incoming connections from an IP address not whitelisted in the middleware's manifest. Currently only allows clients from within the secure network.                                                                      |

## External Services

Traefik automatically finds services within the cluster by searching for Ingress objects.
However, it's a different story for services outside the cluster.

There are a number of approaches one can take to configure external services in Traefik, each with its own merits and flaws:

1. Create Service objects with `externalName` and reference it in an Ingress
2. Configure Traefik to search a Redis database for rules, which is populated by [Traefik Kop](https://github.com/jittering/traefik-kop)
3. Setup the File provider to point to either a ConfigMap or Git URL, which is managed here alongside Traefik

### Service Objects

The first approach is already prepped and ready to use.
Just create Ingress and Service objects in the [`external`](/traefik/external) and Traefik will automatically discover them.

This is a straightforward method that uses Ingress like in-cluster services, but Service Discovery isn't automatic.
An external service's ingress needs to be managed here rather than within the host it's running on, which isn't 100% ideal.

## Architectural Choices

### Why not use the Traefik CRDs?

The CRDs are installed and will be recognised by Traefik properly.
In most cases, I find the normal Kubernetes Ingress to be simpler to understand.

### What about TCP/UDP routing?

Most TCP/UDP services should be exposed directly with MetalLB.
This is because Traefik has no way of directing raw TCP/UDP traffic based on hostname, because that's just not part of the incoming packets.
Since TLS can't be applied to these either (in most cases), there's just no reason to involve Traefik here.