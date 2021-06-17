package offline4.problem2;

class JCC implements Mediator {

    private Provider JPDC, JRTA, JTRC, JWSA;

    JCC(Provider JPDC, Provider JRTA, Provider JTRC, Provider JWSA)
    {
        this.JPDC = JPDC;
        this.JRTA = JRTA;
        this.JTRC = JTRC;
        this.JWSA = JWSA;
        System.out.println("All four services are initiated through mediator");
    }

    @Override
    public void addRequest(String consumer, String service)
    {
        switch (service)
        {
            case "POWER": {
                JPDC.addRequest(consumer);
                break;
            }

            case "TELECOM": {
                JTRC.addRequest(consumer);
                break;
            }

            case "WATER": {
                JWSA.addRequest(consumer);
                break;
            }

            case "TRANSPORT": {
                JRTA.addRequest(consumer);
                break;
            }

            default: {
                System.out.println("Not a valid request !");
                break;
            }
        }
    }


    @Override
    public String serveRequest(String providerName)
    {
        switch (providerName)
        {
            case "JPDC": {
                return JPDC.serveRequest();
            }

            case "JTRC": {
                return JTRC.serveRequest();
            }

            case "JWSA": {
                return JWSA.serveRequest();
            }

            case "JRTA": {
                return JRTA.serveRequest();
            }

            default: {
                System.out.println("Not a valid provider name !");
                return "NULL";
            }
        }
    }
}
