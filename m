Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8285977D6
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 22:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbiHQUYF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 16:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbiHQUYD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 16:24:03 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64B65D0FD;
        Wed, 17 Aug 2022 13:23:58 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HJhDgo016241;
        Wed, 17 Aug 2022 20:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=R76lP3AzURDq9KCtHW6OEGaGDPztS05XG6F311jae7U=;
 b=OzN0k0kR4uhHUQrtB7GpcSBrQuPTXJnnl31cqr9mJopQMq7vp0Ka0Kb8Z9s8YPDGgLI7
 ikshsaufjKD0ex9O8s8vm2gL+29ZfjDhFGJBIyfhYOa2rDUBsu0lZCuBf5dAKZSm8bcP
 1VXX2tnkKjJXxj6X1ku4vPh2i3QBCnJuDmGrC4zMFxXjhkBSFERM0e9BK8GX3+i2j77C
 4J/xVeoSsinY01oywZu/c2L/367tp5DOd9ovm/YjRuNeOyK5wXysIguGFDO2s87DPZaR
 sqWY7xo+eoGBb2/sKh7yPfePtyig64n7f99sa7Z1u2DZblP7ku5nXKYwNJOukwrn2fCD 5A== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j16qx8baa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 20:23:04 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id BF79D800E87;
        Wed, 17 Aug 2022 20:23:01 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 17 Aug 2022 08:23:01 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 17 Aug 2022 08:23:00 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 17 Aug 2022 08:23:00 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 17 Aug 2022 08:23:00 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btrtdksE3B/lAyorwcG6WJ4qHT/YqF0LRoBWCWr014DKjJ7IXtLwyA1aMeikPH3fgmdWrxrLnMeIO2qvNI+yie0fhbgKUUPKxEMOlJXrv2mOtF9KBgS3Fcc5IR9uKLdiKUiNc9rPcAn01UgvhFgmbySpq2HlBA++9pBdqUHn0RCdHqvLn+TexbIM7WbuEL2TJIvInG8ClyUtUhjqYvhcwlgrXZPa5Z4zaeUyIMj/9bvToD6FxbKP8fqJqAnI6JX444XKdX426NKfR8aPV/NmvmIaTIh0/OjGoo7i33dp5TiwZ0q+BFcsNb1SPakPaURaa2bOax0D/YhhwUKlqMxUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R76lP3AzURDq9KCtHW6OEGaGDPztS05XG6F311jae7U=;
 b=FtqDDlEO8On1K6SBn9d/LDd0ZSHCtyvhIjLMgIewsCBabnGyDf5l8XStdg97zaMSI7jGb/u4+gtFH2de6yDaw7lejaAIGGVm2pHKM0307zh733iUFLy48Mv2UZiWXaHi8BEhzEvzGzsXydhsPqwyEcrxmRweVvZ/D+A4FFmDnXOL8WA+Dz+PZ/iakv9mwgu8Ezh98z6Dw4U3eZiNMxi6oVN39q+cJPwHLZJgQy30hmcJWuCscfbFZoLx1EipnZiHe4cp8Kqc6/VEwvoQLK8oZwNr4bwj6oo7JmnAOM58DsmE+X+JLPLDBQt6E1O1VGCiEK9bxAo7Aj/HoXi5HMyaCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by SJ0PR84MB1529.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:381::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.27; Wed, 17 Aug
 2022 20:22:58 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d%8]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 20:22:58 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Justin He <Justin.He@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Robert Richter" <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH 2/2] EDAC/ghes: Modularize ghes_edac driver to remove the
 dependency on ghes
Thread-Topic: [PATCH 2/2] EDAC/ghes: Modularize ghes_edac driver to remove the
 dependency on ghes
Thread-Index: AQHYrWP5SAOmNkRRRk2vGxqNR/QEGq2rWbeAgAV49oCAAW4e0IAAkRcAgAC+XmA=
Date:   Wed, 17 Aug 2022 20:22:58 +0000
Message-ID: <PH7PR84MB183888AC20B37A3D891C332D826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220811091713.10427-1-justin.he@arm.com>
 <20220811091713.10427-3-justin.he@arm.com> <YvZnrTrXhRn8FV3I@zn.tnic>
 <DBBPR08MB45389A9DB098F1AC14C19074F76B9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <PH7PR84MB1838203B478319EA45167BB4826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvyruNX+BUi+O3Df@zn.tnic>
In-Reply-To: <YvyruNX+BUi+O3Df@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa7fd344-c804-4a48-c2b5-08da808e4681
x-ms-traffictypediagnostic: SJ0PR84MB1529:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bEDhl7/cATifOF73yO1UJtu3rTtBQ5aRuqQ0YlURInpWwRgERNB5lAeENbwcRAZs4GcWMy8DJMyiEhfci9PE4e923qjlUwHq64cttaeXRLi4Ot9tAe1vCO9EiZVAfWX8XVrOA7hjWqNBZhGlKmCo8GrZKPhFDGvONIPfk5iIrLz1m5NNsSA59r1qurPW4DyXH+FUQ0V0DJ4QZ7RYBDISO9b9/LuIoZEjN45HEQkFOfoQ/1g5J8JOiQTA5GQ3eLiPs/ZsdTF78xmS/7CJVNwDFMo6P4ugnO/mk4tF+d7ObclI5Gpl4Y+lGRjYdZO6lvezQFMHf0QwG8hePhEUVrjpEeVztUWXMvrGTCjCX0ZtBO9zgXeg5VNBWkLkCYQcyjDvktaqNjMRwM9kRLIbwAlw0d1keAjcN7MEhuLTdOzSUUF+otlkEVb9eedKJEjmkKQThauEMXwn9I795v3sWyIDIYgFxyQX3GvJ2ReS4di6E7GTwsNf3ScE7aQkEat/LmMFBxlOG5OCfGdJUSWXV98xDC3LrjQOHv7pcjm3+rDm+7srIvnE9O6l+tLG1J4KIaUKjHMl1JmG/bJEm2lQSnG/ZdnhYioWjcCRcXYkvV3D1sGUBQO+yoyJaPYCPpGMKbbMR0gyFacXl25GE0QeyW7m2KzVISVAmfXY48gYuD3mVM4FzmavCGuMX4WYPt9eHGajRj/XE36GcARk1kgtC4XUqb2D8RR+1rcl5sIks3RzIJ9EvFbiEvTOJUnHWopn3pqrPew4oY04RwYkwZsOBq32NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39860400002)(376002)(396003)(366004)(4326008)(55016003)(71200400001)(64756008)(86362001)(186003)(66446008)(66556008)(66476007)(76116006)(8936002)(66946007)(52536014)(82960400001)(38070700005)(478600001)(8676002)(83380400001)(5660300002)(41300700001)(4744005)(122000001)(7416002)(38100700002)(6506007)(2906002)(9686003)(7696005)(6916009)(26005)(33656002)(54906003)(316002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0R4bXJtQlBlTlZxUzVNVzBrbjBTa0FTSE9uRWVDU0VFTUJiOUVKN3RWbU5j?=
 =?utf-8?B?cDlGamxGb1IwYVRTem84bXUxbmRwSUNEY1luamJxNmgzREpiaEdaZ0dnRXdD?=
 =?utf-8?B?MUROVHp4WitValZrZEFTdHZOSUo3UGZPd0w3amhTc3czOWtXMS9KUE13YVhL?=
 =?utf-8?B?T0lhdlloSEZ1ekl1eGdPaVJiWUdBNmF5WUNrVXQrcU5pVkNVRDZiN1JTS2xn?=
 =?utf-8?B?RWFYa3pHalZIcmtnYVg0ZGUvaWF6eHpZN0VWN2cxdEJaTWlwbTRVcmZKQ3Ry?=
 =?utf-8?B?NEgxdjVnTE9tRW1Lbzd1bmRqdW9DRWpXNVA2NkFVVmJZTVNmRGJKY2ZiZGtu?=
 =?utf-8?B?bnhqMllRZURZTGR0NkRORGJqK0IvR3FSRVNQazcyejJBOUJZSWZXb2FoWUh0?=
 =?utf-8?B?TENGeDJuNFU3SCt5Q3hUY1Y3aHpaWlZYR3JuOXpDem81VFQzRXR6RDZML1g3?=
 =?utf-8?B?cGRVMmR4WWhjNHhwbVV6MXVHTEZRL0o1RnlnaVFoeHp6NnNsY0NZTjVydjZ0?=
 =?utf-8?B?d2pHWlRuUlNBbzZpQ3lDcVFxVXZmS3BIV1RDVTZwakZSa0hxRXpCbFZRWW0w?=
 =?utf-8?B?VEplODZXNzVGQlR3S2pMSmtYakp2WVo3dUxwT3piR3FCajY0UlBWQ3VUNlZ2?=
 =?utf-8?B?UEJTSCtkSEw4UFZaOWNqZXRCU3d5ZEFBMHkvTDBkaDhlQW5tTDk1UDhIN0pR?=
 =?utf-8?B?eUNrUWo0V2FQTS9GTGJUTThiS1ZUK3lubHNGUEViTWFFUWUvWWN5Q1lQejBD?=
 =?utf-8?B?a2ZYd2pkSUpTOW52N1BzNmgzK3B5QW1KM2I3TUFQVW45RGVxQ0FXQUMvckY1?=
 =?utf-8?B?ZzZsQjhZWnFkTFFIbFdwQUl5R21RNFc0WG1zN0EyN2VQYjBDVGhiSEFNblR2?=
 =?utf-8?B?T3VONnIvYk12OTB1VjVYRXlaUDNseXMvVUdsbitCaEt0MzhxbG5ZV1J6VEUv?=
 =?utf-8?B?TUFHOUo3VXpsa3JuN1U4bWF5NnhRbDlYcU5mZG5DSVE4ekhpUmFEekVLdHIy?=
 =?utf-8?B?T0o5REZxNnYwYStRYUVxV3pXUVF4cWpQS3UzbHZXSExMTFI2NlJsMlRNeWxO?=
 =?utf-8?B?UmM3b3hHZC8vOWVKd1poeThCcnpnZmRIS0dZRktCOHlqWXNwa0pTWDl1cDFQ?=
 =?utf-8?B?Z2JKWmlRWUsybTkxUDhRSHIwRTgyU3NWQ1FYQkhrQ0VaSFUwa0NTTHl0VlJJ?=
 =?utf-8?B?UDI5UG9KYjRNdUNBTHpLSE1RcklINTBsV1lCMlc2SUlwbExybHlhalRCTkJk?=
 =?utf-8?B?djkyQ3lpV21ub3haVXlnSWNOallKclZzSXY4b1M0SnhNK3J3cFl6TTN0RVZS?=
 =?utf-8?B?T1JsRCt2aGdZanoxNFF5RFJXWHExdWw4MFJ2OEMwdFdIMnFnaDR0QjMyQ21s?=
 =?utf-8?B?WVdqall1RzJVMyt1SUhod0ZjR29sYk41VUw4eUgvTGRBdW54b1hPcGhuVmp4?=
 =?utf-8?B?ZUlHelNZc01LalIxSG1VYk1ORE9VZ1FwY1B4QXpXNWhzS1Y3d3RlSnRkZEhR?=
 =?utf-8?B?S2lvZ3RVeGF2ZjUza1BEV1dIZGIxeXlPVy9acUFWOS9jZVJiaU5qS2tMbmt0?=
 =?utf-8?B?aTMzT0IrbkJpYjArL1crdkp0SXNVQm5DTG9oWGFjSVZ4UzFVeXVPZ3dVeTcw?=
 =?utf-8?B?MnNuY3pLUnU4RklLNUhGWVNjdHJ2SnlMVVJQNWNUVFFoVmd1UDJQblN5MENN?=
 =?utf-8?B?eElnYnhRWDY5bC9KWUFmaElmWU1LUHMyUEg0aGZ2NWNyeUpqUzI0SFZBRW9D?=
 =?utf-8?B?OTNFaEtDWGgxZmVnSmdUdFIrTDhTMk92WEJ3bEZ4YnZ3bFV6WVJ6NzgwbkFh?=
 =?utf-8?B?b1M3L3BUTS80TlpHaUNpRFYyVHBydWdiYjhabk9ES21jY2NvZ3ErcWt6WXly?=
 =?utf-8?B?b0Z3MVJ4dWRXQ2FYTjhPTzdlSllkMU5NVXBJeVZMMHU1cllVcW5TNDE2eTdy?=
 =?utf-8?B?dXNkOU4wek9IVHQxNHFpL1F2OThZdko3eW5WQWtvdGVkdVNEMUo2S3J3T1Jo?=
 =?utf-8?B?OEduUnlBSlVnN3UvN0Z3Y1RzbEFCK1VFdjJDOFp1aERMUXBFSHB2eXNjTnZ6?=
 =?utf-8?B?anBFUG1qRWxEa2N0Mzg1YXdyZExCOWVId29ZMlVFd1dsMGVmU1AxU0J0SFRB?=
 =?utf-8?Q?GLIE9KXMFn2kntMfnQqGYlv0S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7fd344-c804-4a48-c2b5-08da808e4681
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 20:22:58.2342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lB/mGTfVS4KT6/55MnWMvAWeTUP4re0gUEkay0THOVqqCPmmLSqgUsebR8EienS10xEWjdrXeWdtUutLVDqtig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1529
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: kcW_XOkKaD_kWHJ_yjgid3xseK61uUoN
X-Proofpoint-ORIG-GUID: kcW_XOkKaD_kWHJ_yjgid3xseK61uUoN
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_14,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=711 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQpPbiBXZWRuZXNkYXksIEF1Z3VzdCAxNywgMjAyMiAyOjUwIEFNLCBCb3Jpc2xhdiBQZXRrb3Yg
d3JvdGU6DQo+IE9uIFdlZCwgQXVnIDE3LCAyMDIyIGF0IDAxOjM5OjMyQU0gKzAwMDAsIEthbmks
IFRvc2hpIHdyb3RlOg0KPiA+IFllcywgYnV0IHRoZSBpbXBhY3QgaXMgbm90IG5lY2Vzc2FyaWx5
IGxpbWl0ZWQgdG8gdGhlc2UgbW9kdWxlcy4NCj4gDQo+IFRoZSBpbXBhY3QgaXMgbGltaXRlZCBv
bmx5IHRvIHRoZSBtb2R1bGVzIHdoaWNoIHdvdWxkIG90aGVyd2lzZQ0KPiBwb3RlbnRpYWxseSBs
b2FkIG9uIGEgSFAgc3lzdGVtIHdoaWNoIGFkdmVydGl6ZXMgYXMgIkhQRSAiLCAiU2VydmVyICIu
DQo+IA0KPiBZb3UncmUgdGhlIG9ubHkgdXNlciBvZiBnaGVzX2VkYWMuIFNvIHBsZWFzZSBzdGF0
ZSB3aGljaCBkcml2ZXJzIHlvdQ0KPiB3YW50IGJsb2NrZWQgZnJvbSBsb2FkaW5nIG9uIHRob3Nl
IHBsYXRmb3JtcyBhbmQgd2hlcmUgZ2hlc19lZGFjIHNob3VsZA0KPiBsb2FkIGluc3RlYWQuDQoN
CmdoZXNfZWRhYyBpcyB1c2VkIG9uIEFybS4gIFRoaXMgb3JpZ2luYWwgaXNzdWUgaGFwcGVuZWQg
b24gYSBub24tSFBFDQpwbGF0Zm9ybS4gIEkgYW0gbm90IHN1cmUgaWYgdGhpcyBjaGlwc2V0LXNw
ZWNpZmljIGVkYWMgdnMgZ2hlc19lZGFjIG9yZGVyaW5nDQppc3N1ZSBpcyB4ODYtc3BlY2lmaWMu
DQoNCkl0IG1heSBiZSBzYWZlciB0byBhZGQgdGhlIGdoZXMgY2hlY2sgdG8gZWRhY19tY19hZGRf
bWNfd2l0aF9ncm91cHMoKQ0KdG8ga2VlcCBpdCBwcm90ZWN0ZWQgZnJvbSBhbnkgZWRhYyBkcml2
ZXIuDQoNClRvc2hpDQo=
