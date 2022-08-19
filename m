Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C8359A5E9
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 21:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350452AbiHSSyi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 14:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350555AbiHSSyg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 14:54:36 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1705ED037;
        Fri, 19 Aug 2022 11:54:35 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JInREQ029107;
        Fri, 19 Aug 2022 18:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=qOFt3y066fg1jgM5hy3KNEihabkDVpyhDBP0kUVewgY=;
 b=AgAsLUlHs3O7ow1e3HgoUPDS03FFXx5/Rb4khTZ6HdI0fZFBBHGptUYgEng59uztdlk6
 hfY1nvF2RlblDHXSgHfog8PnA/5+8DBk3s6Tl9gsyIGIQnP/4vEWaD02ZgJ4p98c7zHh
 akBVheYr6FHEl0AJDu+RmKRYRMqyAwU+X0ydzPO/5V7euBMLrM2XVlw0kppfxwfV5uax
 PAW93+myGS0nqK4X8GUsdqXSk1Ne+623XKBfFO8UKuh1paogqK0ZIg/uTPm+yBmdGbgt
 gYlkOWHKShuGyfPAbNBHU0zFY0GqQ8Plgm1i24/jG6BQCeckZPCGox8G8sFFJXyZWytQ 7w== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3j2g4kr1a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 18:53:52 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 22AABD2EE;
        Fri, 19 Aug 2022 18:53:51 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 19 Aug 2022 06:53:44 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 19 Aug 2022 06:53:43 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 19 Aug 2022 06:53:43 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 19 Aug 2022 06:53:43 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iseTjGyUrubaI3dhdihQKL/Ten2EljQ15/lVnxiLgcBPOvrfDwYGNA1dktApMKHJJEgIlH8fHlMpF779hKRMjt7g3EO8vji64BkAB6iUwsRMxnosHkmUIsWxrNt0ZBKw/N+HNEsOiTwqCgGdhRlJc3/6IO9op+TMoWl9Lyp/+h83c5KUoOlfdmXc4UxJX9hGy4yy6nz3jG+v+cYCr86WbuCO1GaqukimlxrBeysD2IzxGKVrlzElhWcCFu0H3K5Rmx/SYki2VVOLYSAjRWo8hEiimz5O9qmMj0NcT/RmAOlC0Rf1croQeGKVbsJGV41KkFOiIxGkzbrSYIws4w1NFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOFt3y066fg1jgM5hy3KNEihabkDVpyhDBP0kUVewgY=;
 b=Mkl0VX//gLSap17dWuJ/0Yo9mYS4ikjOYh+1+xGpJ3LijMXRukzaMcOC/IBk+GgtzPCDwUtd6giIqFAft8Fdz/5xa9nRaK05JqLHLWgMrdHOK6cmesJZRFjEemo14MrrJ0+dilQWJpoSgQrsJfnFdokINDt2fGJphSUtumrCF9HQ5kEgUuUSgXRPlA1NFkmQP7+maHyvlfnbSaFZGTAieTaxkOBkmBOWYcJA0qttcf6QzIUWFEj2LUrDDe/rHaf/mQI/KPqh0LqixzyoVYeuwVySnCkVwxxT2KVPPewzmDxu7E34iSiEJUnFeJZLK+Lr90UrE/z9oHF5mgwDy8tijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::19) by
 SJ0PR84MB1673.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:430::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Fri, 19 Aug
 2022 18:53:41 +0000
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6]) by DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6%5]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 18:53:41 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Justin He <Justin.He@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: RE: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac from
 loading after ghes_edac is registered
Thread-Topic: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac from
 loading after ghes_edac is registered
Thread-Index: AQHYskazgdaGLeNebEWQzyv29780RK21ZjbQgACj04CAAE7iUIAANdmAgAADCCCAAAKzAIAAAGBA
Date:   Fri, 19 Aug 2022 18:53:41 +0000
Message-ID: <DM4PR84MB185311667EA26C06348F6074826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220817143458.335938-1-justin.he@arm.com>
 <20220817143458.335938-6-justin.he@arm.com>
 <DM4PR84MB18538A56870A280CDC4637A7826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
 <DBBPR08MB453891E87563F1BBE291248AF76C9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <DM4PR84MB1853B213F2F45E495D9D6446826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
 <Yv/Wm/Zf0kdGgT33@zn.tnic>
 <DM4PR84MB185306C2C0DE95FF408173BA826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
 <Yv/batVmSf7PDRcL@zn.tnic>
In-Reply-To: <Yv/batVmSf7PDRcL@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ab5a73d-cdb9-472b-1438-08da8214225b
x-ms-traffictypediagnostic: SJ0PR84MB1673:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m+P9L5IvElYweZZ7QQRhOcSJIBqeGIBAHmLh6O19IYWAzU0PPK/8h3XZlRWbXyviMiI2w64wP8TOdzsMgdCrGpvC4szuEpPTUUuhpX4S+98vt3z9OQwQ1GXCddUyJTma04YrAISVFv/1U30OmDbIEB6hKIBDjUzKXGiEjQn1UDVTjaqtWDIhgYRMMVBoV40qLU3VNxbJOfdDhIplcnopiCloDDZAsic0tYQJ1nMKDs5blFyd81jM04RoBOSovcn0xJl/BHMyBc23yYIBXTpET7W2cIF6FabkRvnypx0sgIe0bPVa8MnC2PseFW0jjdxoFNTqhyamQduvcMMiTnvcXmIulcTm0f9Fkk1ze1a0wI9pyjTUNqoEJ/bHV9JScohRH0Iv1lFdsMftrV7AtjuWrNF9MP0Y9ZaP+0q41CF1yfp9Kym0js3TXoWNre8svpX2O1TdIuGvYpeHZdYpQIGjgyoPzdOiecVZghDDGW+Z3Hkb0AxNoWWT6lV97AOvGnjx589xYpF8yNAXDIhxhAugtKWaHxs4tjJEVe82v/7hRyNgwcs9EUVuAxYz0JS3eCETP9FHgGtt/uk126rpuvjj64W0UUSiqxYTnDQkLnaNZJkXM73SzcnGwIRoBtXR94/SNFIlfGZid8AtWPSoTsyXbn2uZD20TjbbprVYps35Mjzb6aTn8YAfEUmIzK2Tq+KR4Zt7JYrwBoT4VrcTZcWPfllDfXIpxlBitvoKfdJcYPyIJVibV1+ZROWezbMMDJQDVTaaiRPYpKOoqmwkcduD/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(346002)(39860400002)(376002)(4326008)(8676002)(64756008)(66446008)(7416002)(66946007)(2906002)(316002)(6916009)(54906003)(52536014)(5660300002)(8936002)(33656002)(478600001)(66556008)(71200400001)(558084003)(66476007)(41300700001)(55016003)(6506007)(7696005)(26005)(9686003)(53546011)(122000001)(38070700005)(82960400001)(86362001)(76116006)(38100700002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVVobGFUckRlQ3owKzBOc0NlQzNIN3dDM21kdXZvZEJKWDN3OGZVbzZxYzgz?=
 =?utf-8?B?NlRhUW1zUDBOa01icEJ4SzV3SUQ0TmptVis4NXp3Qk16Y0dKRDB0VFhlREY4?=
 =?utf-8?B?YUFmb3pUeng5TVRTVHdRZ2t5TkZlc0NJUjBQbGdET1ZkUENtdTFPMGs5anh6?=
 =?utf-8?B?ZkhzaUhoc0o4SzV6QlRCVG5JR1BEL2tobFFVQXQ4RkRxMTBSZjhhdmlab3pW?=
 =?utf-8?B?aEErUWRDdGp2Rkp0V0pDcU5rTGo1RnVLUVZPUml4NHRnSHZYcTV4aFNsdWZP?=
 =?utf-8?B?K0hvb0ZKRDFHOVQ2QWZhdGhSWUVwWWdPK1g4VkJmS2VOOGNTcjlvS2t3WFRj?=
 =?utf-8?B?MnhCYThEZVFMZFJ5ZXhCMmgvK0hDUUh3YXF4WDRBMVZtbnVlMGlDU215UmJC?=
 =?utf-8?B?KzJTcVpqcEh5RjZDbElDMjRrMlQwRUhJbUppeVlwOEdIcWoyem55SStlRzNJ?=
 =?utf-8?B?c3M0dkJ0M2NLeDNieVY1b2l3NTZrUkZUOHErQk1vZ1d0ajJ3OEJZZXMzMFlz?=
 =?utf-8?B?am12N2VRNXhNU1pwTUMrSFlQdi9DUnhXeTJ1bDROU0xOSkE5NzRINlRQWEgv?=
 =?utf-8?B?OHRNRHVUeGdVRFl4MFVHTWwrWXRxRXVSTjZoVHovZnJKUjB1bVVlWU1qVXZB?=
 =?utf-8?B?c200VlJHRDRiNDFRdTJFRWk2T0ZhSUkvZzc0cUwrRlp5anc2MkFLZGYvYzdp?=
 =?utf-8?B?V1oyUjlEMXRKQmdsUmxKUk9LMjdmNjJwZUoxUzdYUHBqcjB1SzNJZ0FEdnJr?=
 =?utf-8?B?Ym5FNlEycVBmS0NYeVJCWExpWkJMY0dFMkVGSnNuOXI5a2N4bU9DL2xjcjYx?=
 =?utf-8?B?eDFwelRZRG03dmVaRGltUkFKZ2E1ZFRFMGV5R1Jyb2JuWG5hWVA1Wmp4VGJL?=
 =?utf-8?B?czQrSGNwU1owbFZ6WDM0K1ZOaWZXMUlkVERiMjllak1INjFwTEVLOVNRcGVx?=
 =?utf-8?B?Uk1PZnlRZjEwV2p0cVovK1lMMlMwUWk0eUFpbUFXTGZ2OGdpUm1Xb2xxVWlT?=
 =?utf-8?B?L2RCakxhOXBuT0dPU3VuMmxHN3ZZVEhZcVVDS05Ec2pCTGFJMkkzYm5qSXV0?=
 =?utf-8?B?NnlzcjJlY2xMbjhjc2N3YmVRTEx2cHdnL1BxVWNZdzd4d01jUTN3UXZVVExD?=
 =?utf-8?B?ZVNHNC9TU1k1NGRCZTRYQVJ4Z3ZlRVhSN1R1ZGU1eUwzb09JaDdRYStRUmJN?=
 =?utf-8?B?TWNJZE55dDhYekdFV09BdEZGSGZEMXBYYXVrdEQ0dWdUTzhlanF0OGZMMXNS?=
 =?utf-8?B?U2FqK0FCMTFjRElHSW52UDFvUFluYXRnWkNzRXp2U0VUM3ZicmMzRE1KODh6?=
 =?utf-8?B?L2pydEhVNkVxdnNtbGZwR2tVamFIQU1wMU1qMWo2RTc5Z1FWaEFTeGljcjQr?=
 =?utf-8?B?bFhlMVRTNmhodGFVQ1cwaGdqSnhpbEFHMUVJTi9GZE5RRTlXWEo1WFF1em9O?=
 =?utf-8?B?NFp1QUJOQllUcFpOTWFaVnRINWxtQ0RKeEZVSDZ6MndCMTJRRXBiQzhwZklC?=
 =?utf-8?B?ZEo4Q245V2FpeXdLczN0VEc4Ym4zNFBTUTBvaXZOWklMRGdZOGwrMUNFcmpS?=
 =?utf-8?B?VmlTNExydG8vUG1IUm5uUmtGYkZtVDNVcis4bjVOUXZ3RGIrWVh0UTZwelF2?=
 =?utf-8?B?WXZ0SitvTmJGYmdlTnlGVnZQcWZnUGowRmVpVFNlZnR5Q0lkRkZ0YTQwWTN5?=
 =?utf-8?B?QVpsZXk0WCt1QWR0emdxNTdDbXBoS0pmMHNpcGRaMURqSy9ZUHI2Y2RnanRE?=
 =?utf-8?B?RHZ3bW9aU3BKOERJK28zNGJnSnh1eHJoWjN3S1RSdGp4QXQ3TGxVcWRFdVB5?=
 =?utf-8?B?Sko1bGFIcWpJOUZmRTlVME4xU0VPSzJKd3JsQ2lWU1lOSzZhT3J1TmNjVzFF?=
 =?utf-8?B?WWt5VzVJNUxIZXI4VVRtbUxzdVNkUUR5c2RGNGRHcFJzd2t1Y2xKSC9yRlc4?=
 =?utf-8?B?SmcyY3BiUjZpaVZ5aExMZ29IbUlraFVldzdBT2l2Q2hlMEVDbGhnOGVtZW9w?=
 =?utf-8?B?aTJRWitwV2tGMmJHT1A2MnNUNWNBdWpMYWlLcXo1WVZrWGlMbWRhZ2lmUjha?=
 =?utf-8?B?eW83Z0llcGdBZkpyR3FzWmZqNzFmWm5zUWE1UGo4ZVY3YTZUWlVCSGQ3eEtY?=
 =?utf-8?Q?8dfIwoXAF8pjDJBBn8JKgJHGg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab5a73d-cdb9-472b-1438-08da8214225b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 18:53:41.3072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9tu5FbD0wqhr4p/LY60FAZAMbt9SfgvVtsP8elODOjy/3pBP4NEongGUuF4rmArIWrfytPREXfHB0tN1D8vIfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1673
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: jJCiPaB_qxEDhtlojJxDs9toyUpsvpBP
X-Proofpoint-ORIG-GUID: jJCiPaB_qxEDhtlojJxDs9toyUpsvpBP
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=655 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208190070
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gRnJpZGF5LCBBdWd1c3QgMTksIDIwMjIgMTI6NTAgUE0sIEJvcmlzbGF2IFBldGtvdiB3cm90
ZToNCj4gPiAzLiBnaGVzX3Byb2JlKCkgaXMgbm90IGNhbGxlZCwNCj4gDQo+IFdoZW4gaXMgZ2hl
c19wcm9iZSgpIG5vdCBjYWxsZWQgb24gQVJNPw0KDQpXaGVuIHRoZSBzeXN0ZW0gZG9lcyBub3Qg
aW1wbGVtZW50IEFDUEkgR0hFUyB0YWJsZSwNCndoaWNoIEkgc3VwcG9zZSBpcyBtb3N0IG9mIHRo
ZSBjYXNlIG9uIEFSTS4NCg0KVG9zaGkNCg==
