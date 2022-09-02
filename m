Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E70C5AB74C
	for <lists+linux-efi@lfdr.de>; Fri,  2 Sep 2022 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiIBROx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Sep 2022 13:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiIBROv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Sep 2022 13:14:51 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A501139;
        Fri,  2 Sep 2022 10:14:48 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282H9K9r016725;
        Fri, 2 Sep 2022 17:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=YNIDse07olkYKVBqhkEPEy0X+2MsJwW+/NIatVrvILs=;
 b=aLfhrWS7SyLV8uZ/IHl/0TE0mYf4gVxcTVV/i3jwsiP5cgV5dYQXlZrvTK+2ThiT/LoT
 spGQBo9vIlnDU25TwiuyqR3L85QcxBznSswwqbPCGCOqpzsfPJ7EsN+AdU4lcERJE22u
 cyu00daLfwwXhQFD09IkOImeEi3wCi7GDSWEsB7jrl/uZHEaM4Fyrp3Q7zupottsJcUZ
 hP2zuo02TtGVQte8j5MKeieRKnFq8VfzQQLHLX+1gU8z0DAHHs6MfdhOYKMFFWnbHOg4
 xPdb2QefLxWqTp5i7PFDqCgSlhhh0sv1wGYflYvA2gb4zLTp99qehlMDQJJVQjB6u56W YQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3jbnyyg0wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 17:14:12 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id D268DD281;
        Fri,  2 Sep 2022 17:14:11 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 2 Sep 2022 05:13:26 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 2 Sep 2022 05:13:26 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 2 Sep 2022 05:13:26 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 2 Sep 2022 05:13:26 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8JXeRjAUCdGHetH4FyCDSZX8iCyXw+a4cu4E7kqyJqT+aDMgfBhr44MUNEM06bvsU6HDaP0TuCtfZNOw7OKrQnFj5Iw44cH683F75U47DRy4pi8oVR135Yj/ckUhBuqsGsurDAn7JCEGuu3wyvCGlI/yKQvcNpTG0lI9WrJWLIjf4kBLpsqSF4+FrfDPbTeNlAoxjo7UUSYSb6H9m/KvYXDo0BSlSs3MbVo2uLDCH/bmYASARKybdvRXzecFMevbh8pgZgKG3IWCdUbzmyD6WXadakV/vvMv3WWOWCrGkjNoimO35Fyrbk7oBBRuJ8qjPhASTzhCkSWj0npM9Dqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNIDse07olkYKVBqhkEPEy0X+2MsJwW+/NIatVrvILs=;
 b=ANMkg+pGg7yilAJb6Nzjbnn7K1xokGqu/lEmmCfIbSoujWKOdbwlNr2ZBfb462EuTw1t301PCQuLR1ztlrPnniY5QTa5H5/vUrLbmzo49WrzG2kC/P3iG2Z3B5orkHI9l1EvkPlUCOYlcEt59R4XqqhZqkkcbDAYGu8m8XYulxVPvasqKcP5umw6GJ/awzUWg1OQAJavyk0UwFu0GmtTf80gvkoGC/Hc7JkoIHrdFLP4Wq2pjkYUeILnKVQ8w3S22ZQ4eiYhvx3Ld7ojKvX1aB+bNvdoWoRw3xXyxsoJ/hXM8JVZzUb5QMzphXlh7nOWffxNU/Gk/Lzurugl19LuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::19) by
 SJ0PR84MB1532.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:432::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.11; Fri, 2 Sep 2022 17:13:23 +0000
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6]) by DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6%4]) with mapi id 15.20.5566.021; Fri, 2 Sep 2022
 17:13:23 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Jia He <justin.he@arm.com>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>
Subject: RE: [PATCH v4 5/8] EDAC/ghes: Make ghes_edac a proper module to
 remove the dependency on ghes
Thread-Topic: [PATCH v4 5/8] EDAC/ghes: Make ghes_edac a proper module to
 remove the dependency on ghes
Thread-Index: AQHYvQ0gLFRG5y0niUeXpc2U7DO/1a3MXSXw
Date:   Fri, 2 Sep 2022 17:13:23 +0000
Message-ID: <DM4PR84MB1853F07391E61292D4119F21827A9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220831074027.13849-1-justin.he@arm.com>
 <20220831074027.13849-6-justin.he@arm.com>
In-Reply-To: <20220831074027.13849-6-justin.he@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2871d11-3818-411c-875b-08da8d0670fc
x-ms-traffictypediagnostic: SJ0PR84MB1532:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vwvau0PF9g8xlgdR2WnXCNXcnxsz9qATvdjsJP1G8B43fwHLyYn03/pL1CzL7dcPxBHXS2m0syJ0dqGm65M+zVejsRWbvy3PExzhf83FY8q/A9HgI0vJM150w265lFvpMqHShYuOTQEdnPsc793z7RQdZ0fFkf/5o1YN9sOW52XOaxxqo9VwI8fARD3EaUsi64bXzb2wffJyhHv/GRL8eM9jhzHtAvOuSfLVCWjwnjotkeY0vvPNtg9BhjJGHDWbmyNI1Fo8kmYhFxfspE1dtqa1LT5qOKSI1lnQwaNCRcR1culNoe+y3T8NwXrAViXuzy7viGr5bklNv0BWYxRuz7W3dSeD4Dbgcc+djflHqmPHa+aKievCxrxDYJJwcVAUFD3bLG1RyE+lwDJdaivAtLbWsKDqQpZA8QjnB5OpXVfIm4vHvI5NKS2/WE430nYJIKOjdT3T91lleSQQtk1s8pAkrah2GL5yXfprtuQGVEnaWN9myCdIGhzXNioIoDbr5Ozf8saXBWbdb2YIjgmcIarkKgP/ALrvQIEjAcsgB0cB/6WY8G+BXJU+R8hCI5gHr7OFpxC+WUIBgajXhKuzEob5cUTZjbaK0tJKHh9AQ6Pxil7FlOH5GSWYVUEhQTXuEX0cePRa4acBEDNDRSOSmxOAuYM9DaBcea3pGzPgDEjOvVpmADtSDEzOc8M+Swje61k4lt0vVGXe32f2bYFb/uv6knY/TR51nGu7VOXfoNRbF9HgeNJBz8aJ7b7JT74npd2dsXD3qVKufkctDqY8lqMMNU8jy7+/+DsOUB+kMCk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(376002)(39860400002)(136003)(396003)(4744005)(186003)(7416002)(52536014)(41300700001)(8936002)(26005)(33656002)(478600001)(4326008)(8676002)(66556008)(76116006)(66946007)(66476007)(66446008)(64756008)(2906002)(86362001)(7696005)(6506007)(53546011)(9686003)(55016003)(122000001)(38100700002)(5660300002)(54906003)(110136005)(38070700005)(316002)(82960400001)(921005)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B8SY2ttwJtBTPHqzI7eYfwK7eCHy+RHvnP+IE318QpwOZala/dqggLOLxV2S?=
 =?us-ascii?Q?w6XbftFk0aaofJof0QcK0xGOSSR1hgkY872F7bO6AXP+8DcMw8khvQjUIU0y?=
 =?us-ascii?Q?OE8fdXlFbhdWDg3tA/Jfs4HSOIwdF8sQ4Rsk0QYBHYc9/guB8p528tF0SQHY?=
 =?us-ascii?Q?2lgRf7Oqvu7JsJd9sskncHfOyclrT901kwUk9CNxul7TIT5hFthGPm8i+LeL?=
 =?us-ascii?Q?Iil3SGI6Ir0aMLk0vzVLxQTACl1XkzxaQkaKbdAsE9u4GLlN8uyWONMrzcNY?=
 =?us-ascii?Q?WP6MB1gokxbkcnL6siLAbTp1CIK1GRyJSGIMsePWF/DgGTL3H3EAUNI6yZH+?=
 =?us-ascii?Q?wi1eBBsro8FdEsGAuhsN0PusuK2ZlGnsCc7gbnaaP8q6r2jkAsWpIhGAt5Mi?=
 =?us-ascii?Q?rhbHFQ8NVxD8lEla+G/D6/4oFWfOZTPXuhxEvqE4YSL4A8QEIzUDyF6tL3EM?=
 =?us-ascii?Q?lHXvLAVkrDim1PuuD1KDjkHs28YGcKL9MrBRYQGaM5YBlzBVzGdPPwPx/Oeb?=
 =?us-ascii?Q?Z8Zjbl8qfHPgw6guKjBCE9Z2/aCBZfs5wv2cCFj/W+mWWfuzI8DMtNVI6bPb?=
 =?us-ascii?Q?3GskLKFBjqYPqCqXmDEhoIpE2pQLI21cm2Tb9iqFbxNyaN32Jc4zeTHkht07?=
 =?us-ascii?Q?qWmDXYJrO/rSIeogHSHu94+ew/jp+mQd/qYA6OwzIe+YG1oOYdfZsd0kOX/9?=
 =?us-ascii?Q?24ji8wiW4iZ9wyQNbS0s1UewL1EZi3iokbi4PAaf8DPi9FwMG1+j1X3f9iD4?=
 =?us-ascii?Q?KaXIykHTqD4b66JN/ICI5VOa/RKrjQK6BXih3LVuuyn0gLxvVgJdorrBAslY?=
 =?us-ascii?Q?qhJAS/2aZsjutrKUr90KqrQKK3LbmqedPBexu0L0GnjNF47fsPuWxMYWgKgC?=
 =?us-ascii?Q?yMKzbILvl9Z2A5Srmn8aczT0spqafH7z2TqdF410gqxylMTlOiuNgssvcTYe?=
 =?us-ascii?Q?vA5Ph+oIoOHtfC5HgfQX7CsaIZ/GfFCigJsgdk4fphc+N+agk8fd5HEJSqqD?=
 =?us-ascii?Q?6xOE4UqhY7lIZTZD/SQrBIjQ50iRLvbaB/+MqrEhQ6ZY45QVgXkkm6fxYOOo?=
 =?us-ascii?Q?trhPFF/fmoo6ExNWd/G4zeImMn/c5lrb2zNoknhDczw5ikr5KNTyNE2g6hjx?=
 =?us-ascii?Q?jF0VHA0dnwuxKi2RIz7OdtGKd2YG9LRslPr9SCGVVXdRsNMe2hCrANBEFMLN?=
 =?us-ascii?Q?GftrDm4g5oENJvIwquZqDGEKHFa/u602N2SCszdN82Un4TV/8RjJ8mDwI0jX?=
 =?us-ascii?Q?/0VVdYaQ0wilZB0iJG1jVH6LItA1ppnNxNHP3smifWJCkW2EsY4C/fHkwhN/?=
 =?us-ascii?Q?9yDDXUWk3VLgcgL0ymt26wusjtCJ9wFBptTfn+aneP+yZcx+BrB6HLYeQKIu?=
 =?us-ascii?Q?HNVGqhXT29bgUxEEyatNH8WnKlar9sEoIs2inxKQLLcv6k+A4pf8Y7J0nebB?=
 =?us-ascii?Q?97WSR2OYhUbUeyLFR4BNpeZnjrHE/KwizYLayJKIg/EVNe/vTGAkG/GI2W9m?=
 =?us-ascii?Q?GFnuuYAtLINo54wHSWi92RIin5errHpls8HnU9jaXTW/Uehd0ViXMbrOe76K?=
 =?us-ascii?Q?2i9U7QmbLtdFz/4pKUf5aKwRRddKDWXi2DqpZL3U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b2871d11-3818-411c-875b-08da8d0670fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 17:13:23.0952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSVTM5OPEKf92sTxjblRYf9yRc7VmDJ9WWZbDBC92rZzMhkxCHkA+qtWVRf0MTKYFpuv++xzUgHFZK9Y8wjpsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1532
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: OpVxz5tH87eEQxRaMHCyYmmW9bjJf_CB
X-Proofpoint-GUID: OpVxz5tH87eEQxRaMHCyYmmW9bjJf_CB
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_04,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=792 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wednesday, August 31, 2022 1:40 AM, Jia He wrote:
> @@ -454,7 +437,7 @@ int ghes_edac_register(struct ghes *ghes, struct
> device *dev)
>  		pr_info("This system has a very crappy BIOS: It doesn't even
> list the DIMMS.\n");
>  		pr_info("Its SMBIOS info is wrong. It is doubtful that the error
> report would\n");
>  		pr_info("work on such system. Use this driver with
> caution\n");
> -	} else if (idx < 0) {
> +	} else if (ghes_edac_force_load) {

This change causes the following messages to start showing up on Arm.
Is that what you intend to do?

The messages can be avoided by not setting the force flag on Arm unconditio=
nally.
This will need some change to the flag check in ghes_edac_unregister() thou=
gh.

>  		pr_info("This EDAC driver relies on BIOS to enumerate
> memory and get error reports.\n");
>  		pr_info("Unfortunately, not all BIOSes reflect the memory
> layout correctly.\n");
>  		pr_info("So, the end result of using this driver varies from
> vendor to vendor.\n");

 Toshi
