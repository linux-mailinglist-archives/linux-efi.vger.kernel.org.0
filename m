Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF3599189
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 01:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiHRX6Z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 19:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240170AbiHRX6X (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 19:58:23 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD0F2663;
        Thu, 18 Aug 2022 16:58:21 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IMCj9R024289;
        Thu, 18 Aug 2022 23:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=BKLuobYsNTUwbjRVIMluKgKXPMYJY2eq/XX5JFjU8GI=;
 b=BCUCM6FdJZiiSpHIH/jfNoW4ZK/nrTs5oAFVEauNTYXQosXPTOSChI08uJzom+1X54v5
 rOhCzLroAjB7XEOe3LnajwhDKmrdUsxuwZYm8kKkivbLXkE/YmKnl88DVFbmYVwB7m32
 D57BmhJOxqsJK7gOhHPrpjn73SAeQTodAJ/Rc/IYcgX0CAD7VO3dgfkHuyaWJeNpUYYT
 0UmE4uw8aiL88cC/ZOwlcm3ixkE3MUphYqIZDhwjmo1Gd16s7FiP/1jFS6lflE+V1heu
 JOdZazKe0Qx/lWCGf6hhm+UX23taovx6pFK6LFAk/EHYpLPKVx+kHd0sjGbGm1gLmWu6 sg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j1x12gna9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 23:56:58 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 89D8A804C87;
        Thu, 18 Aug 2022 23:56:56 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 18 Aug 2022 11:56:56 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 18 Aug 2022 11:56:55 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 18 Aug 2022 11:56:55 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 18 Aug 2022 23:56:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAMw7YL7PJr/5hkGSUN2H9GHVmscwxMp8slpIVnaN17WmUtxicTRhcZz4ZrVCQXlv6oC2SL+BoM/BrwQ1AnbSwcyAMDlJXfkpX7ueoqAOj6R44EDhfL55YPIeb3q/javB4QC4yJ4aD//4GslYQpqQnBqc5AeT1+U54D3tWrOL0KoSAm14+Y3S3A/zz9dPgwx7+dnqA8iuv5iPWVHNPGiE4LMRDOm1/4S+So1qO1UdLaKK410PFeaxH2BCrcDdzw7qx/WY213pvXc4pjDlyTFaJU5K3W3aIiJaC+oXoIRiAfSWBObtiBVyhiOmFrV/Sr7+Qh3sepMTpvmryd7ki+QfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKLuobYsNTUwbjRVIMluKgKXPMYJY2eq/XX5JFjU8GI=;
 b=BoaeFQ2wAAXixOHeBZBsBzYR+WhbJ2dBPQIxPgO9V3Hn6o9aAB0kIknT3jYNsG98nb5IJucSvVtfJI2zQ+sBYSSh6x0kFdSfTpStVJjvahe1sWtc2F4OFg4jdwniVbN1gKOlFEH/0H/dLsT2tqmA57qUcocCvIbv2r3VgP/bOHM/uE1wbAXD0lugXA9J/gy0VL08fwSVZ6YnbDZ0bYbAhWALS/ZG6cYHHxIiHGbhVnyOKnMM9BwnQHeKbReu/pa3SLB2+6jVEgGGQFcIu2TwX+fu8hTMpurlYQNSo2XuAHkbtWdSgfBSxGphQWmKSFWxVZ46ZVAST8NCw9hEpiAATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::19) by
 PH7PR84MB1839.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:155::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 23:56:50 +0000
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6]) by DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6%5]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 23:56:50 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Jia He <justin.he@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>
Subject: RE: [PATCH v2 4/7] EDAC: Get chipset-specific edac drivers selected
 only when ghes_edac is not enabled
Thread-Topic: [PATCH v2 4/7] EDAC: Get chipset-specific edac drivers selected
 only when ghes_edac is not enabled
Thread-Index: AQHYskavWn87z7ecMUeX7zUOA1U3qa21Vw8g
Date:   Thu, 18 Aug 2022 23:56:50 +0000
Message-ID: <DM4PR84MB18537B0FA6BF7B6BCB583C88826D9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220817143458.335938-1-justin.he@arm.com>
 <20220817143458.335938-5-justin.he@arm.com>
In-Reply-To: <20220817143458.335938-5-justin.he@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d15ce8e-35c6-41f6-9e2f-08da8175517a
x-ms-traffictypediagnostic: PH7PR84MB1839:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qFAywpz7TMu6GIUDplGhFHla8EyNVes2PSwWKIMLKOMWEydf/RGof2zIyMTmnmtZALJ0t95G+L+hKLYV3BiXAaJfMryJfKwgbQpzEOukfWx9pransIO6EfjZHzvwuyDazEnFvAYzMSNLXL8g8KWidOhokqqSE2nTP9kYnWPw3kgmfdYtNWcSn4JhhcCmip53wRpEXo/NrU6/jxCh3zj6M/ABudO1b8K7Xg7qgGiMZUUq1SFLqEEfEyOohWez39EqZI4VeXjAvbZiq/ZfSEy68QjykC1MoFcIGYIUM0DmGP95Bb00HRdj+ZqLOWL81w6pcJiZ7Mq+oi3XIPg2FGiBbqfJDhAx5Bu2xm2UEOSt6OXHFrNto2dFSb7hQh3gvJRjpfwyVq80FJUDHVj9FptNQvRLsd03OluiFDhHLxA91oCnzYAm95wFSF1yB4AGtmoPHcznl1MDTw1vIADowo0c96GhPLY4Iud8/G0H1C0shE7LCQ1pN6T0M44YEst3vTQkaEC7Yjz849MWhczmcCJbXyUAvju8rWVw+tEtqdx132ljZWm/zDV+xGNetu0WUP5gsbxIDB1ORHSfUW57L/NquGACVQFotdfn21f0sxoBoXxZn8q6eVURlG+1JdbQcrsKWdrz5Utc3/PRfJ28dDSJ3j8MjLXhdBVPwFx2gRZTw802n+7FAXwDpuB7s8gHDpvOIRROJZzvBwIV5CdZEt18mXrdBujXfRX1ZcWjyviVhI41Qr0SxA+tBpAtkFV9sXPvaLQ8advlT1uR0jr5Dvf51vY1MKuIjtE5RWxGBz9W+AY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(346002)(366004)(396003)(8936002)(82960400001)(38070700005)(5660300002)(316002)(66446008)(921005)(122000001)(33656002)(38100700002)(66476007)(76116006)(186003)(66946007)(8676002)(64756008)(66556008)(86362001)(52536014)(7696005)(26005)(4326008)(9686003)(2906002)(53546011)(110136005)(478600001)(55016003)(41300700001)(54906003)(71200400001)(7416002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QGPsZin68lBv5Pkp+BX/LJ/nXRftNUOAQkUSYYl+Tl9pVeibOpRbbTQXPMmZ?=
 =?us-ascii?Q?oJZ9+At7nq21Z2S9mgAmjLz6U1ITl/UkpSIx9ddEcezukWe3JuKltSPgYmDu?=
 =?us-ascii?Q?RQWfi2nD1OJ3jP5tpPjoUgS3JfBTpHeMOdV/F0dYD0r2a5b7z9lYx2rv4Owa?=
 =?us-ascii?Q?ZUTTa/usdWpH/bex/ZQkTyeOhPwFMUdqGavdnMV9IZdNfcqkvIESkjHvuv7b?=
 =?us-ascii?Q?g1b1JwMTg9+XOjrxwV33cyEy+MZS4qigdjrxaeW8D8kuBSqT5ePc9Rg+mYA2?=
 =?us-ascii?Q?sIGnqfVVtaFL6nC5kwNWbNfHNbh7Wt3VbyV5wjAuA0hs7MloLNtxxjn2/M5M?=
 =?us-ascii?Q?AFTdSTo+YnZfpbzKkssgwH72uylcwnekhEKaPy4pwj8R1LzkoFppEfNKCy7D?=
 =?us-ascii?Q?B8SSbyJbNakKZt9KSkn1IVYHTw98nqxB/wY9+6IwynZRSPEBR0+c2cqO+gbB?=
 =?us-ascii?Q?edXhwHjMCXWtzQjT7iaLLcf9FT8TOHkL6m9kzHxbjH+A8I//OSiK12AcMWcG?=
 =?us-ascii?Q?fX/Wl4cISyPoPQek3vquYzXNCVH7lCo7nP8UV5nIP2Qss54SllpnQNgfvHJ1?=
 =?us-ascii?Q?+TWnVFgUNNucrapkW/JB6JSIgG4AZxoqF15Tu58nOLneg9dk6UOWah7e94zv?=
 =?us-ascii?Q?V0TeNuhoRat0K3EX9ZGUO+kMlSaWnf/Ax9/IsNb3KkBw3RxyNiaMzhGb3UaV?=
 =?us-ascii?Q?CkM8oDxlVBxjJ5fjutmQdDQO8z9vCLP9NyIK9XuaLJj1QmH2EyMdmWouP2fG?=
 =?us-ascii?Q?76CNFX+SF9eQMYrIGjaoHZJj6OUPvaJ453AIZ15asY3GJ1suX80LgMXFOhOL?=
 =?us-ascii?Q?TEgafJp6Htd552iNNo+uk3bNit7op0/4+SQ9lC/1mOY+jg1hU1ebk3B+OYid?=
 =?us-ascii?Q?wJxQiahiwvJHgbuEYNG5doAFS5n42+mq+DIsG82nfZgG8dIoKd8F4a4W8MTS?=
 =?us-ascii?Q?+KCF7XZ0EBbFoOwRgIJJZS9DL0sxSbKqNBoLdkbnnyvulbIRWEWO6UzvBrpl?=
 =?us-ascii?Q?vKyc2j/8i+mSLfmo8OfM+vbWUl8QSvYJOzGAgjWNRk++NkdWvBlnvR/pDmhL?=
 =?us-ascii?Q?zHGbpr2621by4GiBVPGwuA7tsJ0UBSXAucxj+QqA53sE/L2sW2S8bbTqh7UJ?=
 =?us-ascii?Q?2R+y8yIUkfeFmZNnR5Vi0LUIIdz3F+OrFDNtAz3TczzWCV2sNQJazqk09GvO?=
 =?us-ascii?Q?wFqmmTadCZ6tNQRoligabM6Ruv+sL2fghc/gy/bVVLfFOFyO+a0eMBduuMJ4?=
 =?us-ascii?Q?V83GT4ixtWCDfBW7ABa9yMHRsKQRzyXCRe0tCzabBQcnbiNYxUx5h+8F2+Vp?=
 =?us-ascii?Q?c8CIA01TVZLYZStJaGv0EBcpsBbayG4MLmZPabYbPuPAcpuCu7vskUQn3iOH?=
 =?us-ascii?Q?v6LYV9W/gHqk90IcyRC68Jj1Px2B3OVqzelAdJcsfQg/+kiwHzc1NkftVFib?=
 =?us-ascii?Q?YSLzKWMnWg+fUnrRviMVaK1ok9ixh6o8g0XgQhNi39zsuhbgj/0RdRAH1aqD?=
 =?us-ascii?Q?lLrLixwQppUs+nIwCxjqd7Lsp2v99HPyI4rDKxlSXsVAiVUGWOelDz21t4o0?=
 =?us-ascii?Q?oQ2FJyGpVFih+qsN2xMpRn14px2fwxZI/58qTq/R?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d15ce8e-35c6-41f6-9e2f-08da8175517a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 23:56:50.4336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNGQupoq+tyzqLFU/snDAWv3AqYIf78qn9BuIzUsRhisnBhkAQyl+ec7nauAUqSiAvXnx2RG5kFne0Lq3XJdww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1839
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: wgwaZHYi8iJTWXZqmdisDHoIl1SPCVXX
X-Proofpoint-GUID: wgwaZHYi8iJTWXZqmdisDHoIl1SPCVXX
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_18,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=868 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wednesday, August 17, 2022 8:35 AM, Jia He wrote:
> When ghes_edac is loaded, a regular edac driver for the CPU type / platfo=
rm
> still attempts to register itself and fails in its module_init call.
>=20
> Suggested-by: Toshi Kani <toshi.kani@hpe.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  drivers/edac/amd64_edac.c | 3 +++
>  drivers/edac/pnd2_edac.c  | 3 +++
>  drivers/edac/sb_edac.c    | 3 +++
>  drivers/edac/skx_base.c   | 3 +++
>  4 files changed, 12 insertions(+)

Can you change i10nm_base.c and igen6_edac.c as well?

They are listed in your list below.

On Monday, August 15, 2022 8:20 PM, Justin He wrote:
> I assume that all those edac drivers which used owner checking are
> impacted, right? So the impacted list should be:
> drivers/edac/pnd2_edac.c:1532:  if (owner && strncmp(owner,
> EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
> drivers/edac/sb_edac.c:3513:    if (owner && strncmp(owner,
> EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
> drivers/edac/amd64_edac.c:4333: if (owner && strncmp(owner,
> EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
> drivers/edac/i10nm_base.c:552:  if (owner && strncmp(owner,
> EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
> drivers/edac/skx_base.c:657:    if (owner && strncmp(owner,
> EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
> drivers/edac/igen6_edac.c:1275: if (owner && strncmp(owner,
> EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))

Thanks,
Toshi
