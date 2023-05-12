Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB35E700CE1
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 18:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjELQWs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 12:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjELQWr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 12:22:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D7746A5;
        Fri, 12 May 2023 09:22:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4ie0027798;
        Fri, 12 May 2023 16:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=334dHYfWxu7QKxzlEtWcTMQz69EPVUXMJnO278tvKjY=;
 b=0d3haFRwBX6eY6YLtHhPD3xXAbqtiNcT5GvcWlq3DzhOGoaQioy+PfBqQ2/U2E6D/mup
 J0aIx3aeTOZkB/AQ4Oi58teVx92A0Vdd5ltPpStj+IHvpyPomsUPwbx7lPVbx6n0e9U7
 2FHtGWN5LhKzW2Pfl5KG225xtuEgSi6s8pOf+o1e0Nrj5dhsU2PgL4bMzVSHHSbT3POU
 48xMzBoSTNma+U/8R1ZujkYI+J47QH1TlyUoXgj/NtV6nq79XraYqd6XlVBeW88xchcZ
 VcV6Mp54xNfnQxigCVSpiWTMj1+a6hGL1BZdU+DNfgJJ3DMt6CcJKdZr4TjAQj36Y2xO 3g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77cb6pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 16:22:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF9MIv018122;
        Fri, 12 May 2023 16:22:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77me9gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 16:22:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjzgaCu+Eipfh6noD7oKVcr0TFn8aj2cJPchRIG0WoY9yUjB0ALGtOjLldzy1gew2T3xG7z8+1t+VtCIwoajW/lrblgR9kzNW4Hb+BvJpaZuCXxyOWr7qYu3zbEI4Hi7xm82wGLMzKm1JMXwmFZ0LmryWKiKPOb4cEg6pLuxSaU46LWeTEEi8o6kXOhJSRQiUFhk4CQMNy20GzdlSJEqCGRg3+gGiKciWMFBchpvxQBHcBD4wk72LAQAQPOGiTB4luUTJpn6ECznSuDb7JrVAjsctcJkZd0K/0w5nDr3ovCXmT5U1pVqf5+c9wSsTBY2MgjiMuBGhuVs5XUYcVEAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=334dHYfWxu7QKxzlEtWcTMQz69EPVUXMJnO278tvKjY=;
 b=R/972O9XduDt7TnRfklJnxyv/TV0WbcsHZCRB46wH9qqs5ZfMIjBzf14CFidRwUcpou/rCxj9a6xaPyN+Z7az10VmLfZxrMRVYILOTJKskSeRR1lJqysAFP9Padf+OJ2BEWsNC/De3VBSWpcQ39FRxRZtaJJe3l7bl2GKvC5C/PnmL8/YQ1vtX423IrI1hnqafupnDj0ecYb4gI+4pbDKtBhrPiz/QqmVrOpbKrY1tSGJ9UgOld5utWKRLSROfSKmcmGWsJoG2FdkojavgZMlXQePSGetjFt8gfqGmZViODWiDn0hrKe9lQzAMDMtzMDSn46EDUKPqe7vkXOYg5FPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=334dHYfWxu7QKxzlEtWcTMQz69EPVUXMJnO278tvKjY=;
 b=ebfWwcQGxu+XzaOo2oFg3qFN0g6NGbCJelgbRnu7UsJYlF/prYC/4HL/jusBCnIuxwTeLhinoZUywTpgCIiA9heAm78vW+cDqaO1uUdk0R76FxsXaH5mptEFQWQVcBngu8TsDezkvLV+ReDiF7K7fkAdAZnUWee7XMQUQQPKu0E=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DM6PR10MB4155.namprd10.prod.outlook.com (2603:10b6:5:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 16:22:18 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91%4]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 16:22:18 +0000
Message-ID: <1c17d8e8-1f34-8f11-4265-ddf5e77e3647@oracle.com>
Date:   Fri, 12 May 2023 12:22:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 13/14] tpm: Allow locality 2 to be set when
 initializing the TPM for Secure Launch
Content-Language: en-US
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com,
        Ross Philipson <ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-14-ross.philipson@oracle.com>
 <20230512114349.GH14461@srcf.ucam.org>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <20230512114349.GH14461@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR15CA0012.namprd15.prod.outlook.com
 (2603:10b6:408:c0::25) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|DM6PR10MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b153c1-6086-4a34-0334-08db53050dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKkcICamBM6ssTGkTWrU6J4jCi96QP3+nPJ2huS+oUqexAK+1lca+0YLQEFRrseOXs9dubUDtJ9WE4NYoVMfdP6aRV9s1Q/XUa/sQXElpEXmWoT1v6kaHiAfoW2OSxZh16fwuV1JpeNaz/ahRSJhzxI7kTLbsY4Bi9T4ioGKcxqO5cgC8PZBpmj7IbEmS9HO7BX4plBQJeiCk1+ckqoz1NR8/Y/4uOBXyudSEM+8wAMPNRoP8esCD52W/gv57TG4VDhmbnHIonAAQhoBqzxVaBzDhhbZJe7auDPqQ5EXSyXYiqV9sGPw/go+NeUhWTg16n6f1b0DtIDzwPTLbCiri+vl2a3zHWmBG0K7QplkvMsuofJlTGlqz5v22PbVdCiDhF1n/P98QM5tZfH/6GWTqyot3NkdfIltAUdfjOD8OnbJOmveapnUFxXJAqm2KKcz8FYDb0vZsutKHW2gyXKn9UYHrZRHlEIhGZBzIGbkWeBeyhFnN80iH7SGeFmFpznGtu2R+C+6u7TBO8NEcMUD+e0b8F7ewBkMVSYA6eOyt28SB5ZHesQvrsZY4rMfTWCDk8c60Ks3WN81lV2u7G8f8YR6DmH29x2jQ+0gDEuxQRSzwfEp+G0SA6Up2ljNATSwxNiswR8QAiIEe/fkUzD6ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199021)(6666004)(4744005)(7416002)(478600001)(2906002)(186003)(2616005)(36756003)(6486002)(44832011)(316002)(41300700001)(6512007)(53546011)(6506007)(31686004)(107886003)(83380400001)(38100700002)(6916009)(4326008)(66946007)(66556008)(86362001)(8936002)(5660300002)(8676002)(31696002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3cyTkZxbGxTWFVPTXhVQTdJQm9PVlYrOXpNczRHZDQxazZ5ajNpMHdJc1hR?=
 =?utf-8?B?VzZ4UDRaaUhkU2ZqVXJneE0wT3lzUnV6U1RtZjZnS0hERUdUMENlWDRiQjY3?=
 =?utf-8?B?K09UNTlmUTNBL1JxVnFJdFNoMDBvb2FRSUxxdWJLclRJZWhvc0tqRFpuU0M0?=
 =?utf-8?B?WmRpbXFXQW9rbFppN01CZDQvbXJSVTNWYkE0OERZT1NnYm1ibGhVN1g4d0p4?=
 =?utf-8?B?c1FiVHNEQmd5RzJVRDd5TzgrVmpzdm56NWhvb0NoT3NXYjlRc044M2ZmT1pY?=
 =?utf-8?B?dmFQa0ZwZ3p1bUIxSE1iSE9oWTcwb3RvWmtxSjZYYjlLOEt4MjBaUExuRm9i?=
 =?utf-8?B?aU9IdnBZSzIrSC9rdHIwN3VsSFhORm5kU3ZaWUVqM3llOE9xbHduU0hIaFFL?=
 =?utf-8?B?OXowUzFrVGg3VTF1YW5CWnVBMWEvVm9aRDJ5UDhNeGY5TUFzZGdiQzBlODR5?=
 =?utf-8?B?aXZOK1plb0dFNHhtNS84TENaOFJLSVhCcmhCRUhsem9zMkdKbXhISjRERjJG?=
 =?utf-8?B?YXhLeGtURHFMdGJnNlc0Zkd6NFQwZ0ZOWE9kT2UzS255SFJldzFzcGtyME1z?=
 =?utf-8?B?bERRdEhoQ2xSaEpxZC93ZHMwZ29pSkluNnZVVTNhZmVLa3Rld3BvNFVaVHRs?=
 =?utf-8?B?cThBekdTd0xoTlliUmNBYXlMVXJncjNqVnZhZnRxK3ZGZnA1OGZYcTRhalE4?=
 =?utf-8?B?SnlMWDRoMG9jNjVuNy9EMVNnUGtTTjJZcGVHSWlZSTQrTjBabHVYTUVNR1RH?=
 =?utf-8?B?MUZUWlcwNkFrbnFaN2tTZG5qZnY5OTVTL0dVVzBLdTUybGl0TzdteFhrV2Q1?=
 =?utf-8?B?aHFHUEp1enRndmtRbEY0aWxWUnlwdm1sYXpFc09XbitpYmxqL1BBVXhsNUxp?=
 =?utf-8?B?N2t3SlNuZnRLbDBtMHhDSWxXYktmcmo0OUtRcUkybFRWWHZvbk00MDZxNjNM?=
 =?utf-8?B?a3VnUFNGbUo2UDliUDdqTE84Ty9DTkthQzhocHpXUHpoNEI5czFVdGpHVGda?=
 =?utf-8?B?eWRFZGJZN3BVaU9IeC9td3hBWjFoZFdUMHo5QW9PWlZBdU5vY282ZCtLVURT?=
 =?utf-8?B?NC92NTRnVWY5NTNXVGtvMUc1QUVCNFhYTEhWR2pJaEFxNmZrRHFLc2xrOWlJ?=
 =?utf-8?B?Wm0rYWQ1R210YmthbkVFR3kzUzJiS2JqanpaUER0QytEUzlpVXljU3cvTlVS?=
 =?utf-8?B?L3BKaFBsUm5obXRrVXhuMEt3SU00bEt1WlE4djJRS1RKV25hQzJzQm40LzUw?=
 =?utf-8?B?Ukl1cXdhdlRyeXg0ZDNiWDdZNk1iNDRLcE5id2lGWVNWc3pIUkpCdVp1cWU0?=
 =?utf-8?B?aTdJMCtGWUdCNjgzRDVZNmJQSzRwUmhMOHc2eGNJMXBPOFFpV1pSR2drS0hX?=
 =?utf-8?B?VDdoejBmS1kvWjFHcWs4VDF2STR4UXo2Yyt2WllKZ3UrK1dQYWtQSkpUNzdY?=
 =?utf-8?B?N1QrMnVtZTFMRFhDQ0JZWXVlcWE5Q3lDajBjTm14SVRaYnRsczJjNHdWaXBN?=
 =?utf-8?B?Z2JYYVNPdDR1RzMrenQyRVRUTTY5ZVlUbGlybzAvT282YldjeDdxYUhQSmFa?=
 =?utf-8?B?L05IVGJRaDl3ZnZaMUUxY2VUY1VyWHl2U1kwN2w1Nm9sa3NvZWs5ekRFekJF?=
 =?utf-8?B?Z201OW9tclNreTFmQVpOSjVxUjlBUjUxMjU0S2g5c01ZaWJha24wWGFDQnZ4?=
 =?utf-8?B?UmhEWlZWUDFqNVVIQXlpOFNZRUZ5K2VFVWFlc2dlQUlYOXdodzJ3L1E1WlVt?=
 =?utf-8?B?aTZRV1QvSHJ5eEZKbTd0ODJzM3AvSHoxcDEzRGxOa1dQV200SzRBeUwwUHY2?=
 =?utf-8?B?eWh3Y3ZVZmVqYmlqQ29RK05tMndNSVY0dXVVU2dOQlR5ZVdXWDRMOFU3aXhI?=
 =?utf-8?B?bWoxNURITU5lSG90VzhwM1Z0R21KSzdxQmNwQUgwaFFUQ2tPTnd1RXRXOU9a?=
 =?utf-8?B?M09QZHJLNm1EcmE2QVlGRHFHRWFPdFlZd2R3K3daaUptbjlPMlNsTGVSbk9R?=
 =?utf-8?B?emVaUEltQzVVWXRCeEhjY0tzNWFUOGJDa21QY2hrVGVQeDhCYWE0STZIVEJk?=
 =?utf-8?B?ZUY3OUF1VUdsY3lVeXZZbGhYbHdTNzZmYUhxNHk4WFBiY3c2WUk5UzVIUVdW?=
 =?utf-8?B?aGJxZ2ljbnZNa0ZIbW5tbmVYOEZ3d1dGeEpHejhONHNRVlhpd1JMbUtvTzc1?=
 =?utf-8?Q?Zn4EAFDznKZcDBc6Y7iqEeA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TlRLcWFRdmNPL0RlUU11TnhYK2NSK1RJWnl0MDdTVmFJa05aYzVCTGJCWGVk?=
 =?utf-8?B?ZlZtek1yaHRhWFJZQ1JVYWkwbFlRTzNWSld2MmlmdWF1N043ZjViQythWnhh?=
 =?utf-8?B?M25yb3poSE5QTEZpWkFxSjNxZ09ydHVLN3V5VGJNek9qclBlc2o3Y0pBdlQr?=
 =?utf-8?B?Q0F2dEMwbmJEa2tnNHQ4Ujl1cDdCQ1V1cDhUbm9rOCtSN0ZsL0tZUkxWbmh0?=
 =?utf-8?B?TDlQT2xOYWVEeXRvUnBRV3BYNUdVVVMzQlZYVmhKL25HUFJKMXpGTEg3VUxS?=
 =?utf-8?B?bmx0NWY4azZlTjNWM0lpVnBndXk5a2xmcUkrVFFzb3V1Mk1tWGV5MTZVREhs?=
 =?utf-8?B?bWVSSTUzYVRpQ3lMSXRiQ3JnRksrNzdIZ0g2VHJPd2RhdTljVzdMdDUxNFZ2?=
 =?utf-8?B?Z2hWemh2YUlid1Z3MnVCc0F3TWhKR3Q0d2ttYU1tMDNYSWpDZWw4NWR4Y3RW?=
 =?utf-8?B?czExUjUxcnN2QjUxbjRGQlQ0cXBzRjFrZElCUnI4RkFFRWp1eHdkMUJKTzQr?=
 =?utf-8?B?bnRROEx5TmQ4bXhvWmoyczc5TTVhajdEVktNaXd0cG14VHJiMzBWNGh5REpN?=
 =?utf-8?B?cXFuWUljbi9UakZvY2krcXlZbTZ6VTNza2xHdW5FdDI2T08wSkZCWVBxSUR3?=
 =?utf-8?B?Vm9JZnU1ak9yNGZyMDgrNytLNGZpNjBkTG5LdnlkVzRCT0s3OE1xdzVwRUNk?=
 =?utf-8?B?ZTlTTHlJTVZoczJRdytyMzhKSDBlSHlEayt6YzExNzlSNS9mcnRjUDdIWlhL?=
 =?utf-8?B?Y25iZFc2NnFsY2pvdzBsMEpkeHc1Smo4VlpVYjI0aGtkNTZod2pMaUFYSHFE?=
 =?utf-8?B?K1hFVzBsSy8vK3VUNWVQenZaV0RqTXdnbDQxOTNNOHZJUHF5ODlxS3hBeENB?=
 =?utf-8?B?WDRhR2VwWDNqa3NOK3BvRHpZeTZINHNSblcxVDYyVHhWb2FrUTVpTjNDMjdn?=
 =?utf-8?B?SncrVDEwUjZkcDlmNE03a21EYkxPN0RxbnhGQUJoRm5GUzdnSG9SdXpzQmpp?=
 =?utf-8?B?L1NTZjJZclpHWGxoQTNSRGYrS0hXYzZsQmlYVmlqSWF4V2RtS2JSKzBVLzM3?=
 =?utf-8?B?WEN0elpkY3E1OWRXQk1mdHJZSThWWVBQTTBnOUwxOXlmOEcwNjVITmJxQ3FT?=
 =?utf-8?B?anNTa1ZNV0tSV0Q1LzdrbEF4aVRTa3A1a1Q0SE9zQkxsaU1PaGE1bmYzZ3Vt?=
 =?utf-8?B?NU5vM2tzRHRzY1ZUdmJOS0lHUlFYbTQreUJTOGo5R0syRHczZm5RbnZwWlA4?=
 =?utf-8?B?OE5tR3FQbEwrd3g5dS9GWW54UDZWRHI5U3h2MFJSQWlXdEpWbTM0QkFnNzRE?=
 =?utf-8?B?ZDVYY2RCbWwvYzExMmtIUDhwUXNsZlFCMFROd01rZFNEWWRrY1lKWFdkYWln?=
 =?utf-8?B?Y0VJbDFyekJCYUVseStCN095cTZXa3loN0VoU1RtL3ZPRWQ1VWErS0Nsa1Bl?=
 =?utf-8?B?ZXVUajFKNkZUOCt0Qmh3dUtkWVJPTElYNHM0aTFlenlsSVRHdVZSbVNGaWNm?=
 =?utf-8?B?bmF2U04rM1FFOTIxQW14R0VJa1dSM2s1YjI2SzdjVWtkWlVoVE5wTEd3bkN3?=
 =?utf-8?B?M2FDWHVTOHpYZWNuQnJJbkE4R1Q2ekZkN1FnQ21rWTlKQmZESUk1ek4rS1BS?=
 =?utf-8?B?ZWtNYmxLVEdlcm9uL2xzQnhHL0FUM2x1dEs2eTYwWHc5bTN0RXd0cHBHWWNY?=
 =?utf-8?B?STlNbjZXcEtScklPRmxMY3FXQVFyK1dDSjFaYjZTTlRKZTVWdlcvU2g4VEZE?=
 =?utf-8?Q?p+Ef4jiMk+ZgI2eDak=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b153c1-6086-4a34-0334-08db53050dc4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 16:22:18.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lv5xYMtJrN6XRo/kdfZwysELW5Y9pB7m70EHmb2QtvpdwkRaXJeMhI/AH3tTJjsmrHSYJnTjBkvTUBD0Yk4Wmns/BQenHrsmnjUxjswOlas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120135
X-Proofpoint-GUID: 2XufxxI_ocDbx0s_mxL6TG9UN5eFRztL
X-Proofpoint-ORIG-GUID: 2XufxxI_ocDbx0s_mxL6TG9UN5eFRztL
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/12/23 07:43, Matthew Garrett wrote:
> On Thu, May 04, 2023 at 02:50:22PM +0000, Ross Philipson wrote:
>> The Secure Launch MLE environment uses PCRs that are only accessible from
>> the DRTM locality 2. By default the TPM drivers always initialize the
>> locality to 0. When a Secure Launch is in progress, initialize the
>> locality to 2.
> 
> This looks correct in itself, but looking at the CRB driver code I don't
> think locality support is actually implemented. Are there any SL systems
> using CRB?

We have never seen a system that supports CRB other than some firmware 
TPMs that don't work with TXT in the first place. CRB is unexplored 
territory at this point.

Thanks
Ross
