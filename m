Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407135966E5
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 03:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbiHQBk5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Aug 2022 21:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237611AbiHQBk4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Aug 2022 21:40:56 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C511896775;
        Tue, 16 Aug 2022 18:40:54 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H1OQZ6012265;
        Wed, 17 Aug 2022 01:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=bSBitafHSfYw1eWOScUITOqxmGh1rcepp4NI+GssMOU=;
 b=NAzbimI2KlNO5+JuIlP9RAanIG/LqZF6/XfpExwlda3xZQrKNvYe3SpUmgQcGvEKQ/PT
 ufuIoXRn+LtaNkckaH3PQuS6/66yhLtHuRwKhxMAXzjdztmYcxNtkbbL3jkjRcwv+Kop
 jtl9hmRK6WbHd/QzbkO5isbieh1A8bjzhi0/iwFME/IPXiatSi8mJvSrKGk2qPYbnup4
 Z+uFMIKkxvvJSMoVSf0sDaRiyoxEHwRjZxDGSd1S65CbE7M/hhnAwd2HCN8wjLDfUomC
 8D/3uBZAl3CvkRXOpghJZ8Vhwq8H4I0wLnIRZyWY2MNWwUPxwNUum1HpRj/d/CRp3N3w hg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j0nre8f9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 01:39:58 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 7078FD282;
        Wed, 17 Aug 2022 01:39:56 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 16 Aug 2022 13:39:35 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 16 Aug 2022 13:39:35 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 16 Aug 2022 13:39:35 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEWgBcDVFDt8ekwkOuBY5hFrgKhmZ6+e9fueATcpjpzFuPzJcNSfo430r22UqjrKF7Zvg5NfC5jx1D8LKAr/GzdjYOZYKgcgIrqZ63o+Hes2pfHlgJWlE2tf2Bou9xzkwvGO7TPSmbmcj4S/4y63gTgWf3nKC2IekGBWnxNgSHKtOoyCfbN/S62+rRkXahVHimyie62V6/SCD1ww6q/2fx/9jp+kcUT8PLdP6Na6/eQGtyKc/n9aQl0a6Pc0cCCAZ94sodrgCu9qsUFt6PbtRR/2Cvu6FLiAzllr/58CGPIUlhNSYv70ZPCit2Pu9/KPfKjocahJycUj1vKk2BBvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSBitafHSfYw1eWOScUITOqxmGh1rcepp4NI+GssMOU=;
 b=RZv3BYD096Jx1brLZU9yzsfWbX4Mu80ToQwpeq/DP3SZjdrkqYPkK2Byj5byx37eC4bTkSphKr/nvrFQFzeg9L9hr08QaLtrGY2o0a2zuAW8gVVjVObcepHDkn+0q4kQv+fX8P44BRrsqUafL3QM+1MpMUODsbJSyrUDZ+eL05H1sVXvh0ebEzrbvnAmhfbs+qIWR8jHAthdnnrMujCOWFfNQtaFHgwcBW0erDgCRpAKHDaCd57oLRaK1YFh9EaswOk0QkcnqLMnJcGzUictr0tv262CufAYMD4nIJoHSabwkXK6WrbARZw4yOwno91QTxbSvGaMpo6o36OCdsn0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by MW5PR84MB1523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.27; Wed, 17 Aug
 2022 01:39:32 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d%8]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 01:39:32 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Justin He <Justin.He@arm.com>, Borislav Petkov <bp@alien8.de>
CC:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
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
Thread-Index: AQHYrWP5SAOmNkRRRk2vGxqNR/QEGq2rWbeAgAV49oCAAW4e0A==
Date:   Wed, 17 Aug 2022 01:39:32 +0000
Message-ID: <PH7PR84MB1838203B478319EA45167BB4826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220811091713.10427-1-justin.he@arm.com>
 <20220811091713.10427-3-justin.he@arm.com> <YvZnrTrXhRn8FV3I@zn.tnic>
 <DBBPR08MB45389A9DB098F1AC14C19074F76B9@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB45389A9DB098F1AC14C19074F76B9@DBBPR08MB4538.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1dff84c-9e21-4d24-f21a-08da7ff155a4
x-ms-traffictypediagnostic: MW5PR84MB1523:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /oxNOl+Y2JP+6RTL63dRdFbI2zfO5pIPDufFeeJ0VbDUGKQVGjnSjT1Xdq5UEaUYLBfMWQpi1GknC3yF7l9w5ZKYULdEhqaaq/c2RG7ZR5r/I43zWMwLbV4y7tviwDP+D+43zTgZ5rQOk9xzw/Yy/rZWXPjmtm2sK8o0Ae/uTt7H1/xZnH3IE5uzuBhRzOFl2kOrk3wDE+X0ggeCEWAisbu7o/gXHcrfnqVCP/nRKWrf8ODWPBJuoOnQ1DyQ91CpGk0UTS65hWmLRUXUSMQ+lQ9ldI7Aod+739t0PxUOjHLNTdjhZe688PGcGLPXhmFTXVAXNKtDj6g1iUWkwhFUBhuiRffVEKziHb7voNU7svoa/1GesPd4vnkSpFGIo5Qj4EfjEgSNgdfybkZ9I3cyhWieEaUD80apqnrFfj+HsTLb1Gb+WFeeFtwfhQY7p5yyNobdJ5loDv5MZfFg06/pmf9q/Rzb0uV931twFPiqkJI2RBXqLnGwVU/kyov1mhrDR/+np1RwxufqDMKtDevrVi5Ua1sS86xzuDuwYdAnGD9C+Omus/B2w6ztmPwr5lXgmbY/DwADwbqqTklQf6+s9RSrOwQCkccJycI24acZ7t/nlMUKostr+qnXx0tbP58KWif6XTeS5g6d4CYTnsW9qxCZxJJ6kPDXheviuFyrIlNKaZkF70we/MmVxSBXhyIrgDwlRzvSEWjxIjx1plgp2AtVN69e7bY+UZj0P/VaxtS+XrhS+doF0jgWC2HRYFcSY2S8VtpvjahbnscEUw0U3p7Z13ayywtMtvtbEimt2m8B0jHAAoloAwJAqvzXI0Js
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(366004)(376002)(39860400002)(316002)(7416002)(8676002)(4326008)(64756008)(8936002)(66446008)(55016003)(52536014)(66476007)(86362001)(5660300002)(66556008)(76116006)(66946007)(83380400001)(38070700005)(54906003)(186003)(110136005)(82960400001)(478600001)(38100700002)(71200400001)(53546011)(41300700001)(122000001)(9686003)(7696005)(2906002)(6506007)(33656002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THZaTU4xM3VkYkN6L2NqV1BYREJ1TFp1ODFsRzQvT3d3MHFZVjRFNGRZRHk0?=
 =?utf-8?B?VE9MYjh2Z3lYNXhTSE5XcXNZcWxuVDdtb2RNbHNBZ09sOGhXVEg0Y2RlNEZs?=
 =?utf-8?B?WVFDMUNoMnZ6eHF4RWdHNWY3VUJENThCWWU4VFpwSWZQWVVEdXRnL2MvYVNo?=
 =?utf-8?B?OXdEMmx5SVZEclBueHkxYjFZK1dHOFlpa2RzQzJHVXJMUWpQc3dxKzV2dUtJ?=
 =?utf-8?B?NGU1Um1ZazJ1MW1GbUQyaGl5WEZNK1NSWU55YVFqbVA4RHozS0xQMk00RDg2?=
 =?utf-8?B?d0gzQjRSNWdIK050UWE5cllZU2VBazNBemlUa0FoVG9QTE1HaVdzeVh5dmNp?=
 =?utf-8?B?QTBObWJXWGMxamxSVWRCNi9DRjJRUnBEMXo3UjRPVkZIQW1QZjg1eUFramJk?=
 =?utf-8?B?VGpyZ3cwdjJnZVV3QUFaa3YwazBENDVpSGp0NFI1V1FFSVh1L1RlcW9kd1Jx?=
 =?utf-8?B?cEd4dEJyYmx1QklyTHdBUC9uMWVYVmlTa0FXQ1FWbHFxOVEwcklXTDFiNFcv?=
 =?utf-8?B?ZEFHc2R2NDZDMnRFdThKMTZ2MDVnUUg3a3NiQ1lDVHNRd1dTMHkzdURZMG40?=
 =?utf-8?B?S29WaVF3TkFDU2ZFZEdIMktNMitaRzE0QUNBdWEvTnE5Z3VzS3NyVlh6UGJh?=
 =?utf-8?B?NG43bEdrbi81L0lGQW5jUUU2ZjltNDNLQ0tibVAxVVhYYkJMaTNFTlZjK00w?=
 =?utf-8?B?RUtsZHlKa0E1a2p3dHQ0WWV2VzkzaC9zZ2Vpa0R1NW5XWVVFdnJpQmVqZis3?=
 =?utf-8?B?Tmc1andSTjZHbXFYWXZsUW1MbTRra2dSMlliMW1IYzhBMkx0Nnd1eDM2RmxE?=
 =?utf-8?B?QkdJRzNndFp5b05LUldqNlg4a1pFSUdWMEtTMmQ4WUlWS0oxTWJ1TG1Qa2Vh?=
 =?utf-8?B?SFBFOC9QVzQydjl3U21aTGxYUE5nWDF1NW5wSjRyWTIvemVMakw0RWs4clVt?=
 =?utf-8?B?OVIrMWdkc2h5WlB1V2F0eHF1L25vZDRzeDRoUTRxK2ZLS2RyUTJxbCtickM4?=
 =?utf-8?B?Q2pxaDFOcWtRckZaei94UElRTkFWY29TTWxBb3VaeGFDMnZvdlY5S0EwM21Z?=
 =?utf-8?B?cjJXVDgxeCtHMWUxS0lMUHA0NFJkeFh4Ri9mN3R5UTlSTlZQRU1qeERlYVRi?=
 =?utf-8?B?VmltRkpDekthajhuTlBrbWlsL3pGaVFnTEFUK3BveFhrWk16eTd5Wm5tdzNY?=
 =?utf-8?B?Mnhna2xFSnZreE9iMloyZWVCZ1hlU1pEZVFPQnRUS2s4RWpDL05QSThNd0hu?=
 =?utf-8?B?Uy8wd0xsZVQvYStKOTdvbXY1WE02TnViUHJoTUxIVm9BcXU2NDlScDFlbytG?=
 =?utf-8?B?Tm42UVkwWWJ5WCtTTGJLQ2I2cTY4dkRPaFBQMUdZNVUydzhraXRIaHJpTVZk?=
 =?utf-8?B?RG1IYU1EWndJeHRXU2EyK3U4c25JUVFLRGw0OUxHb0VxS0VTZFlINVEwdUlQ?=
 =?utf-8?B?WWlsRXpWNzlyRmdVNy9PTUM5M3VxZjRQUXhIZERONG9HclNhUnhWcjFlTWhX?=
 =?utf-8?B?MXQ4bTlId0RteTdpbWVLKzVtWDZrN1IyRm1VZ3Y5WlQyOEc5R3NiaEVhRSs1?=
 =?utf-8?B?Q3p6dHB0cjJBaUc1N05pZVB5NWViVVNjK0dLeEN2Z0NHUE1tRnEyV2JPWmtx?=
 =?utf-8?B?a0VBTWNSaUVMUllQdTE0MTRtUk1ZbDFXM1V0UGF6WW5UZi9aQmwzQzc5QnFM?=
 =?utf-8?B?d2Qza1AvSkJQRU5IQTZKRGsyQ0ZnTzFrNk9LRUtYME1BRlQyM0NIVEhBd0xI?=
 =?utf-8?B?OHBPZ0pQOE9HSTNnS1ZpclZSNWpkTVhVaFJSUG5nMHVrUGNZdTVSdVBpbWQ0?=
 =?utf-8?B?Z1IveVNScE0xeUNMSlZqRFhsdXg4d0s1RnVEb0xHczBwVUlzZS8zSWtpajV0?=
 =?utf-8?B?TUNNZGYwdksxTnE4NVVxcnVPaDVheE9vQUI1UHNuNXBLRUNNUkh1Z01Pd0NV?=
 =?utf-8?B?SXpOVm42bGlnUHRnWVRZRmRCNmtaY3ZRaUYvTEwrRjNMQzNTMDZpLzlNVmo1?=
 =?utf-8?B?YWU5ZUp1dTFIOForbUFXQ3NBUEh1aXB3bGV2aEc1VkxQTW5kNGVCTmJMVU02?=
 =?utf-8?B?bXo3RUkvaUZVcTFzVEFxdjRZVVpVSVU2TXdkRWlmMFl4WUFWQjVvVWVCdE9B?=
 =?utf-8?Q?HhewsSSTpNTfcEJZtiVe/nePL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dff84c-9e21-4d24-f21a-08da7ff155a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 01:39:32.6753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zuuCua8Wlh+wUZVc6vOPMOxZGj13lTlbi6JV1QTaaAf+p6Jt2GvZUchfmj/nl8nDEKwYEDgcNPXZwbwIRut/Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1523
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: No-SPMIoNeWAEhM45QR9zR7BsSwsN3VM
X-Proofpoint-ORIG-GUID: No-SPMIoNeWAEhM45QR9zR7BsSwsN3VM
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 clxscore=1015 phishscore=0 mlxlogscore=907 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170004
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gTW9uZGF5LCBBdWd1c3QgMTUsIDIwMjIgODoyMCBQTSwgSnVzdGluIEhlIHdyb3RlOg0KPiBJ
IGFzc3VtZSB0aGF0IGFsbCB0aG9zZSBlZGFjIGRyaXZlcnMgd2hpY2ggdXNlZCBvd25lciBjaGVj
a2luZyBhcmUNCj4gaW1wYWN0ZWQsIHJpZ2h0PyBTbyB0aGUgaW1wYWN0ZWQgbGlzdCBzaG91bGQg
YmU6DQo+IGRyaXZlcnMvZWRhYy9wbmQyX2VkYWMuYzoxNTMyOiAgaWYgKG93bmVyICYmIHN0cm5j
bXAob3duZXIsDQo+IEVEQUNfTU9EX1NUUiwgc2l6ZW9mKEVEQUNfTU9EX1NUUikpKQ0KPiBkcml2
ZXJzL2VkYWMvc2JfZWRhYy5jOjM1MTM6ICAgIGlmIChvd25lciAmJiBzdHJuY21wKG93bmVyLA0K
PiBFREFDX01PRF9TVFIsIHNpemVvZihFREFDX01PRF9TVFIpKSkNCj4gZHJpdmVycy9lZGFjL2Ft
ZDY0X2VkYWMuYzo0MzMzOiBpZiAob3duZXIgJiYgc3RybmNtcChvd25lciwNCj4gRURBQ19NT0Rf
U1RSLCBzaXplb2YoRURBQ19NT0RfU1RSKSkpDQo+IGRyaXZlcnMvZWRhYy9pMTBubV9iYXNlLmM6
NTUyOiAgaWYgKG93bmVyICYmIHN0cm5jbXAob3duZXIsDQo+IEVEQUNfTU9EX1NUUiwgc2l6ZW9m
KEVEQUNfTU9EX1NUUikpKQ0KPiBkcml2ZXJzL2VkYWMvc2t4X2Jhc2UuYzo2NTc6ICAgIGlmIChv
d25lciAmJiBzdHJuY21wKG93bmVyLA0KPiBFREFDX01PRF9TVFIsIHNpemVvZihFREFDX01PRF9T
VFIpKSkNCj4gZHJpdmVycy9lZGFjL2lnZW42X2VkYWMuYzoxMjc1OiBpZiAob3duZXIgJiYgc3Ry
bmNtcChvd25lciwNCj4gRURBQ19NT0RfU1RSLCBzaXplb2YoRURBQ19NT0RfU1RSKSkpDQoNClll
cywgYnV0IHRoZSBpbXBhY3QgaXMgbm90IG5lY2Vzc2FyaWx5IGxpbWl0ZWQgdG8gdGhlc2UgbW9k
dWxlcy4NCg0KVGhlIGN1cnJlbnQgbW9kZWwgd29ya3MgYXMgZm9sbG93czoNCiAxLiBnaGVzX3By
b2JlKCkgY2FsbGluZyBnaGVzX2VkYWNfcmVnaXN0ZXIoKSBzZXRzIHRoZSBvd25lciB0bw0KZ2hl
c19lZGFjLg0KIDIuIGNoaXBzZXQtc3BlY2lmaWMgZWRhYyBkcml2ZXJzIGNoZWNrcyB0aGUgb3du
ZXIuDQogMy4gZWRhY19tY19hZGRfbWNfd2l0aF9ncm91cHMoKSBhbHNvIGNoZWNrcyB0aGUgb3du
ZXIuDQoNCkhlbmNlLCBjaGVjayAjMyBlbmZvcmNlcyAjMSAoZ2hlc19lZGFjKSBldmVuIGlmIHRo
ZXJlIGlzIGFuIGVkYWMNCmRyaXZlciB3L28gY2hlY2sgIzIuICBJIGRvIG5vdCBrbm93IGlmIHN1
Y2ggY2FzZSBleGlzdHMgdGhvdWdoLg0KDQo+IEZ1cnRoZXJtb3JlLCBzaG91bGQgSSB0b3RhbGx5
IHJlbW92ZSB0aGUgb3duZXIgY2hlY2sgaW4gYWJvdmUgZHJpdmVyDQo+IFhYX2luaXQoKT8gQmVj
YXVzZSBhZnRlciB0aGUgbmV3IGhlbHBlciBnaGVzX2dldF9kZXZpY2UoKSBjaGVja2luZywgdGhv
c2UNCj4gZHJpdmVycyBjYW4ndCBiZSBpbml0aWFsaXplZCBhZnRlciBnaGVzX2VkYWMgaXMgbG9h
ZGVkLiBJZiBnaGVzX2VkYWMgaXMgTk9UDQo+IGxvYWRlZCwgdGhlIGVkYWNfbWNfb3duZXIgY2hl
Y2sgaW4gZWRhY19tY19hZGRfbWNfd2l0aF9ncm91cHMoKSBjYW4NCj4gZ3VhcmFudGVlIHRoYXQg
dGhlcmUgaXMgb25seSBvbmUgcmVndWxhciBlZGFjIGRyaXZlci4NCj4gDQo+IFdoYXQgZG8geW91
IHRoaW5rIG9mIGl0Pw0KDQpJIHRoaW5rIGEgbmV3IGNoZWNrIHdpdGggZ2hlc19nZXRfZGV2aWNl
KCkgY2FuIHJlcGxhY2UgdGhlIG93bmVyIGNoZWNrDQppbiB4eF9pbml0KCkuDQoNClRoYW5rcywN
ClRvc2hpDQo=
