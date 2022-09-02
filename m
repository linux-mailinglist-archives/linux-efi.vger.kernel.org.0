Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CA05AB4F5
	for <lists+linux-efi@lfdr.de>; Fri,  2 Sep 2022 17:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbiIBPWz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Sep 2022 11:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbiIBPWa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Sep 2022 11:22:30 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233BFE4F;
        Fri,  2 Sep 2022 07:55:32 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282EsBbI032571;
        Fri, 2 Sep 2022 14:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=ErAdpAFv5Zrtmw5X0aJMXC3jK2xlYjg3V6p4lhXyQsc=;
 b=f6rJuiUus/MWf9OTLZK8aUkV0aArPukCxLa7xhBg08QUh6TwK0acpeZ7de/0h4xNGCXF
 Y6OukAEoqSGFw31n9Ma03svA+HDBm9YSRgJYu5HJLSo8kLkNfC5gdQg2XsfV6kqaD3/l
 Bou1acsili+Axfr4u3K+9CpAMEFdKmZJYU4s+evfXYFAfqE0dD3xz4q70aDsaoxFwKgI
 JUpVKH/5i1DTLEuV8Qe4yZ29Ji27Ui+8gIj2ujRmmUbOcbzjsW2Pu3WLzf/O1Mvu15Tk
 bCaLt2YQQOuamXIFAyc6tpQRZawbLSvBCu2ael852/PSArpElEeL3lTMUwPAvTsCjDLE mQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3jbm0g805f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 14:54:48 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id ACAC3D2B7;
        Fri,  2 Sep 2022 14:54:28 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 2 Sep 2022 02:54:28 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 2 Sep 2022 02:54:27 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 2 Sep 2022 02:54:27 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 2 Sep 2022 02:54:27 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpNvqRzR6VwStRVgnOV2JRSfLkZmicQIvZARCoN9hZRrnbKYlsLiHyJSWX08z9pdE7rW5/hCZl1jcjK1L7Kf4CzSPSM/NOuEb22ecLuGndzzu4C5ilW345nX1t/0sW1WgD3S4+5YJEWBazCYKBY4usf78wHLAPofmuVkW8KgYydOCg3RuNuWDsyfNBsrxExoSpQ8vuiaVUT7EPkdCd7QIAEd9AVNyooZCaoYsHYyUU3jE/OCJC5Ebu6Bs7KzRCMc3DGRpXBLcXEUeFv7kMVRHba8H0EPnbNQIzl0NZXp5bkvYQsExj2Dvr5TZ/B8p5p76wO6PocA/NwSITL1GpbczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErAdpAFv5Zrtmw5X0aJMXC3jK2xlYjg3V6p4lhXyQsc=;
 b=gWHVIU6go/C6LqwfDqg8MzLyRzsWIs9PZinXm7vpkS9NxHEckdHpGYHHmmYYwD/ecPvReA7Nn+f0NGhm65OfVNdtGEaDr8WiJTFbYgvhU7W9xnSNZlsxvBdylOolf5e2kq17+6FpQPszQd83/iD0iluWUMksv6wXWFKzSAu4RXpCUe0QzyTMt7WezXDQvuFtH1b1T7UHAeJUHrKBixrYF+8vzLStp4tI+b06E45ZDRQ+oqIFw9npdeyLVQx+wwOTgAhzTlqN86JhLg+sFBTPrNOGifBGSsuOFMuj3wNLDSAyrEaVfsZqamCbp/l2jqcR0IQsyTdU4gjsClukyREh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::19) by
 DM4PR84MB1421.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:48::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Fri, 2 Sep 2022 14:54:25 +0000
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6]) by DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6%4]) with mapi id 15.20.5566.021; Fri, 2 Sep 2022
 14:54:25 +0000
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
Subject: RE: [PATCH v4 3/8] EDAC:ghes: Move ghes_edac.force_load to ghes
 module parameter
Thread-Topic: [PATCH v4 3/8] EDAC:ghes: Move ghes_edac.force_load to ghes
 module parameter
Thread-Index: AQHYvQ0ZnDLuwTvH6U+YXmEA+QE6sq3MO6Sg
Date:   Fri, 2 Sep 2022 14:54:25 +0000
Message-ID: <DM4PR84MB18539F451E3C89DA2853539B827A9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220831074027.13849-1-justin.he@arm.com>
 <20220831074027.13849-4-justin.he@arm.com>
In-Reply-To: <20220831074027.13849-4-justin.he@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1be3fd87-4936-47fa-46f3-08da8cf30775
x-ms-traffictypediagnostic: DM4PR84MB1421:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XRm2Ffg/ujUHt6FbKOktr2p+QJXfX8qbuNzTzqdYeV7Ws/BcSkMh6F/eEpfhgL1mQulQmwMpHLj13SJAiN9BwZRBRI/J6PrSLFNjc3ePI2g7r3RqNZhlHjoJFoSgWwbXytnR70CfrVOKg0avQH59I7KOc1wqlxK8CYkcXgCsOH63XW3ez8m4amoovkp6w2LIbqVNanEaIhG7Wl9QDUweKS5SCr1xS64oD8C2lbUWdgp2ySbQnj5MyIAj3Jk4FO9Lvbmz5COSoONqrDGxggyLWKQZBzFx5Ye8DW3e3+5ZpSng2eUogMevjvwYhDmr8Ve2zlRaiQ8Y2wASqHKIg/JN1cJ3jWnsqS3ykTfe0rmvnStm/eq51hCemxR/VcskcuqhLKOk6HJzBJ0kkUFLO/rE2rk/LaJSYWyhJ1qHwoIYsWI5wwX/aK1r7eF64CljD612yP4w3dWonvMBzmfi2FNuncbmxe86W1D8R3s9LstVQsUHY09wDKmwLc/R3N3dS5GLsvG40AgycvRc+/fpAJ451GllmfevlQc8I/Z+q1C4A0Tl3noX3D1/JBApEvIS4y/OET9EvJ4syCbBJ4Od5Vu67kh5BhtyY8a0Af8dEYLFruY0OrVa5zHQ4j9sR7r7GLMypgWsUF5YDrrY3a9bM56mQX49o3Lhdp6WIRKg9NlQRwmAYmKGH/2CwIlM+dFuTQlU3myLVopg8kr2pIKPn+riHJqC/GVTTNGr/6wPxoCJT8iXKMjlkmHE+f8b2X5BUTUk2gOS7BLNTvJUM7ZWqkNTulKs6hVppMcvuZFaYxTiqQc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(346002)(376002)(136003)(55016003)(6506007)(38100700002)(921005)(33656002)(122000001)(66946007)(66556008)(64756008)(66446008)(66476007)(76116006)(8676002)(316002)(41300700001)(54906003)(7696005)(71200400001)(86362001)(110136005)(186003)(8936002)(4326008)(26005)(4744005)(7416002)(9686003)(53546011)(5660300002)(52536014)(478600001)(2906002)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g1Ogi2jbOQsJV8ZmkVIGbA2I6MEqNCqgrTGs5L/xDMsJoa0L5rkvaZZSrd0l?=
 =?us-ascii?Q?5aUERWQNSrmUD0rNXgPDYDZ9y2iLRrrquyOTqxpc0XepRimVXuGbGzI5vkIT?=
 =?us-ascii?Q?hg8aCRLjRul0i0pYgKaLfMps3t2Qop/azxAf83dOGx8c1ZLFpmxr7qvXMkTU?=
 =?us-ascii?Q?uLlXefGEfzsdsV69UZLjGsCN5qnkh0A0zm2kxeJ1FIyggZw7TLcKCsGR1i8k?=
 =?us-ascii?Q?CN/aLA/hHaQ0qYJ7JaxyYB/bF7iDan+JjO9ObSlSSujXjLjiszEjqYHQIOQL?=
 =?us-ascii?Q?+5gA8mhxgoavelufl3Yj/qPqCD0neKxlgnxiBnPO+cehHNoQHGdn/hx6jbF+?=
 =?us-ascii?Q?CBxA2iWx8tRHTqZxK/OM20+KFzircWP7T4GYwyBzjGFldWaWWMLxBlxsSb8S?=
 =?us-ascii?Q?ValLFUcwyH8Bdo198vH0l2RkawHtKlI3kvp1+U/q1cnsFGSmUM75hvQeW3lG?=
 =?us-ascii?Q?apGu4w+403IBgC/ciqPnRC4oqvLghVzz+b/IO6pcAsVJ+46XSwgpU5mrKPEC?=
 =?us-ascii?Q?qp8Is9a1HxSk3cla0CpJ7eOG/kCZcNUba1YWzW0kmAoNkSWdlpIf/auSuoKK?=
 =?us-ascii?Q?kBDPfG51xhygeOoKLuTucFBXzpGRYIDCKuTAMTNNFnTcQaAhdlH74XDibz0Z?=
 =?us-ascii?Q?fvjOYm8zkOv/UF+FNA7QR+IsSA+TyVEITvB+dHrH7CwctMHdFKhbQ5OItV+t?=
 =?us-ascii?Q?Lsb/XatuTOXwu/Wr5Xf/A2bgB3Ct68XVqc9ZnCcJrnhbVXc+pP2UK9HjBOnq?=
 =?us-ascii?Q?JXNU59RRSWz7YzzDU8AiyCQ+Z9TJwB+mxTigbN3TuxOF2bBiRbXM23GumWmJ?=
 =?us-ascii?Q?HET7KQJ2a9vg0PzRbQ9rqqiJCZBfhDH0/023pwnBrtj0x35SPQVrIzK8cSro?=
 =?us-ascii?Q?UEUf4UjO+VUmcvI5klNMIWrnCiHX78cEZ8hniXh00125CPNNvYdRAPXdH7rT?=
 =?us-ascii?Q?J7j1fif3a8RXp0hnAswXHyUbOxjaHJFAqA58Sa+XZ15g6cReyJazHrVtpu2/?=
 =?us-ascii?Q?ik35ZigSKILbVSrA9uvYo3TpX1FhzhZo5NXp4vo9lXrIpc9awJQkpNUI+ISD?=
 =?us-ascii?Q?2tXd5zr6u2S05Tl0cfHt+Oj+v4rM5cBMiTrwY8OVEuo1Q/1Ks3p2ibmDhpjU?=
 =?us-ascii?Q?ifdg4h8UtL7md61X5bsCAVsGhJLm7W+C82HOgOLSp63Dqf8S1fV+jgIe3Avi?=
 =?us-ascii?Q?8OgfxBTthjH4fMBws1yKy2GVdCDRftIWr9Qsg1kGyqnMGujH7Th4fZ85iDrv?=
 =?us-ascii?Q?SAsh9hDmjfCAd8BP8XoTQpPcBSLvd9WZVbdDKIqTA8fMacAVj1eSxYRtb4to?=
 =?us-ascii?Q?2OMbJlUJ1WEx0yHBhR973zCUrtZtFs/BI6uHk0rMsiOidWK+6eveIIzfj6vE?=
 =?us-ascii?Q?OG/KWS5MN/rhI9W+DE8mKEtEXqnrQIzFi82f+JCKsXgfbcBN6i6pUkuJjp+N?=
 =?us-ascii?Q?bIPqGymT1HWh5wbbvmRw5YLV48szqGQa+UJjuvXH3VerNhhFONu8iHNizske?=
 =?us-ascii?Q?XwAb+D/2zUblGR1A05UGTFXfyiKAxR7jTXx8k8KvJ5xE/bbSJBUGR+Lul5k9?=
 =?us-ascii?Q?WAT58hdE4j6uTQeF0cnx6XpAJRkyjmKrCtNeXCHx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be3fd87-4936-47fa-46f3-08da8cf30775
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 14:54:25.5789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B9xxpD3U5rOVEgZ92NHsxFHXzCuo2KPnrdYG/fOD9LIs1elYjERgudThA4K/34Z+D+CTOFon7tgKAWR4bkHJYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1421
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: UE_LTAsqhruwRMXkHPjt3rUYSjCrI89s
X-Proofpoint-ORIG-GUID: UE_LTAsqhruwRMXkHPjt3rUYSjCrI89s
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=787 spamscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020072
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
> +/*
> + * "ghes.edac_force_load" forcibly loads ghes_edac and skips the platfor=
m
> + * check.
> + */
> +bool ghes_edac_force_load;
> +module_param_named(edac_force_load, ghes_edac_force_load, bool, 0);
> +EXPORT_SYMBOL(ghes_edac_force_load);

Since ghes has no ability to load ghes_edac module, I suggest changing
the option name to ghes.edac_force_enable or ghes.edac_enable.

Toshi
