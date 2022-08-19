Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B7159A5F3
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 21:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350111AbiHSS6N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 14:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350344AbiHSS6M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 14:58:12 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4A7101C57;
        Fri, 19 Aug 2022 11:58:09 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JI2oha001220;
        Fri, 19 Aug 2022 18:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=wiyvfg2NUTggBPQNcN3SZceZpE6ixAdHlRwKpJsQP1w=;
 b=Do19bpgE8Fu8VZ5Dk9guMnIOKwL5mzqj3glbdA8RwxLX9LV7nM+p1JbNTJedr7r49waL
 /7bHnLkOwfDwUGLnm7gB/E26v88NCwJP2OH4IEtRrRBt/JAMadIU0joaDxC6LuB2hXM5
 x3StBf8lZHMGslU53cnhiy46VKA8IlvvasnswUzQBLVVmHD3zsheKirDGRfALdjNCz77
 mUjYTI7XVxExcFisNLtmyoza/80WbL6VBIEfTRtC6hCRRjyFJOk0k+v5FyjzepOB77Vs
 L0DulBxjPM4arZWbfvPCuLf2t5F9BSN6701d88+9WAJdw92XQJs2JaAggGbaIiiuoDP0 jw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2feqgg6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 18:57:16 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id CB7EF804CA9;
        Fri, 19 Aug 2022 18:57:14 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 19 Aug 2022 06:57:14 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 19 Aug 2022 06:57:14 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 19 Aug 2022 06:57:14 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPzhOyi3O3+rIJUpjpQXGGPk92o0EfHDW8FLuVIMr8sNpCMaHihmuWQM4wft1YhX/5H6w1tRL8nO942GjSRMOnTBMKLA1vk73dvBl0HyqU5siI2bYLhC/lDWXs6bDPtUiF6W2A3UQRVdsfsxRBEI+C36yDsvmfr+BfQIAiCDhfBe/4omeOw1/9KvwLBty67Jhuw/M8faTU6ivW008poTWa+5s5yEObrlzdyAei6peAo3pq0MiY/iPQOs6qkID25nceV+uiuAihbpjmdXQNk3bfsNHEIW/VlYvHJDdrtPIvFxZW/ALY0EtZSzosNrUf+2QHwVgQEU7vc6eebDUCBQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiyvfg2NUTggBPQNcN3SZceZpE6ixAdHlRwKpJsQP1w=;
 b=YoOY4ZMarcHPvs1pb2kitL69w4xXux7dI+pUPrrKskT1JlFQ42yPep5PdUoTdkD5IeOig7II1Mt+m6HLrppQslAm1rs8z+llX4JSzDqfwj4r2DifXuBNQrFR41+ly+RgYS3oPWnI+CCD1kxbQ5mcfcCgjBKagY/d+Q8pIzL+NAXcEZWu9FrixaFVQbnASx4zgdSsKSUIpDRTDKKO3nVtBrQdts86UiSci4jvMZPbbWyGNRDKZN/IG1Ieh/HdpBjB8ZjLppj/sEZtwPcC7v5e/RZ9E8NDGTn4n+svlOsZ4zo5IhAa90+G/am3bK+2KM0+sDskuOM6IJNyIWYaLsKWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 18:57:11 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4%5]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 18:57:11 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "Kani, Toshi" <toshi.kani@hpe.com>, Justin He <Justin.He@arm.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
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
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: RE: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac from
 loading after ghes_edac is registered
Thread-Topic: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac from
 loading after ghes_edac is registered
Thread-Index: AQHYskbLB3dm9/vQRkSlm6bwr07US621cbmAgACYT4CAAHk+gIAADlig
Date:   Fri, 19 Aug 2022 18:57:11 +0000
Message-ID: <MW5PR84MB18429A4A41FD70DCD91CFADDAB6C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220817143458.335938-1-justin.he@arm.com>
 <20220817143458.335938-6-justin.he@arm.com>
 <DM4PR84MB18538A56870A280CDC4637A7826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
 <DBBPR08MB453891E87563F1BBE291248AF76C9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <DM4PR84MB1853B213F2F45E495D9D6446826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DM4PR84MB1853B213F2F45E495D9D6446826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8705f8ee-4540-475f-1767-08da82149fa9
x-ms-traffictypediagnostic: DM4PR84MB1853:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1EMiQD2sdbBinPj/xxk9R24SK7Mqgs+67MorZlLNeAG4c/QQBq5H1Wse5ZI7yq+LAP29JNdgpKLmdvDGv7wYh9hs44++xQFOu4M/zn+0nJA2s/qQXNTONFhpiXwQykbhoIZOMev/PZJzLsAA+6V9KIykK4o6D/JZAD11xqq2NXqGd1aPNb5w+eikjFYNtqzsitl19Xxqhh5Pa1LiFDZL8HZyei069Z7VS5LyjTq452xBNeamPAsAbCQvQZn7VM3BFao1YPLJDRdbj0D+u3oWqUUQh4v6ApoBNNQaF3CxlL7ZUZwVOJ+uAcb0HVuUWxujUKcbunwPLxYsdgRrnNi+exm52VYtU85YV9qwpu9vX0v4bMQ+/zXdRsJV3uiz4bEA0YISZjKLImhSfNdfBWpbwQ7lgJza2Xupyg5qmqbGqQpWiUEQwZR7G/BYWB/WpjwNzINmBOORGIYY+YXRlbfwa25C6E4Tk5zOZFtDpEeZ8cSWphzRJ+BCwne9jVRC7vaa/XT/r+Lkk5T5ULHkHhCbsM8I44DMoXw9AjA+zJQfHWJ8qPNGMLQZhlJ/V9U1VcE9Ruo8HIz3OqBn9XcSeqmF8DJ1AL24mMFOsEDeVq4bgdbbG9aWOz8hjiX/9x1XchXHTnlvOghQkS5sN0SJR270HAnL64VgoYUveOB6R6S5D0N8ubSsEB4kDWZzl7EYqXSpt81/ACABg7HHfnpQygZXJB1gj3Gd1xGWdwv/mw/UXyncD0yle1YYYVdvlSn8dqL/0TKeez04gFQuWFGykPc7Zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(346002)(366004)(396003)(76116006)(7696005)(66946007)(66556008)(82960400001)(64756008)(66446008)(66476007)(7416002)(6506007)(4326008)(186003)(26005)(8676002)(5660300002)(41300700001)(8936002)(53546011)(33656002)(83380400001)(478600001)(52536014)(9686003)(38070700005)(2906002)(86362001)(38100700002)(316002)(110136005)(122000001)(54906003)(55016003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7exOesFobQmxM8QoGiIIfYXFPO+eiK82MwahZKoPCwx2Kz/2A1gXN1Ln7vGS?=
 =?us-ascii?Q?ZCdcFsukbc6imSApIDZodIZI/UxUzGZWGyWcO8OSYYSv/GZJreZ3G1VYy2uC?=
 =?us-ascii?Q?tNZy0Ljz10fOgEt2TQB6FQCSwBT4RKWl1eVyISxu5REXYQxtXVJM1bMnXW8Z?=
 =?us-ascii?Q?/BEczO4eBEW5a/0K9DjhNyrsfASp0WayCSOTh9U+bgAzx+GQJUv/9CB5BeHB?=
 =?us-ascii?Q?xoKhfr3MFVP+gBrx3vMvJ+Etl6Lv1prT+8QsDyjsunvM+uAwSsrNYGGRKuGh?=
 =?us-ascii?Q?Le4zQjRNvkryhEv/K1LXmfOXIeJNsn/JKeRMhxx7HtALw4/l5AEIQNnc9/iT?=
 =?us-ascii?Q?tAhb4kl4+O8CEIi/CT+Q36IXlDCPEHOhpZAyrvnTCqHNomOJ6gASeVp4czkV?=
 =?us-ascii?Q?zSRaQQkAH5soDzg6pi9x9iN2TXLUGS1IJDOpcLrrP5OP/5xRY6T/dpuwf6EF?=
 =?us-ascii?Q?XvzeNwPqquALttChX7lhOe7DdvRJDJ042dhff88yw3ouigDeRBSlD/botPc1?=
 =?us-ascii?Q?94pl5n/A64iGy/9LnlDfq3wAOHdG58AGOykWkNjhedA3rc76Vt/Lt5HUaM5b?=
 =?us-ascii?Q?jkf4L4fhpM8trtEV2hNgQSk1Ef/tvX0nQx5t/mRa1XPh/Fo1/w1F9vYkFj5P?=
 =?us-ascii?Q?p5iczc2ir850BIwDW5IsUeW3GBQo426CQoiEcLPGpR+1lYeaHOSip3kaT/g6?=
 =?us-ascii?Q?Mt9FQjjqUJr6t7oKvtu+nHIII7hCxgXhN0DUpm7JO32KHH7YvmODJlQBcjv/?=
 =?us-ascii?Q?bOAPtkN5Qr5kbvYN6ECEDFcAeMHU7fCJAiuY7MwAFR04E1tqILej2mFaHbnq?=
 =?us-ascii?Q?T7Pfrm9XZkA5b67mr6g9euROWJgBJJIzhww/AaFZGkb6UmQyF5IwOzYrdAs9?=
 =?us-ascii?Q?HHQOyfpB7Gc5mOrFgo52631C42rhiiueV2rt4k/grmDJgZnY7x7nzYT180p/?=
 =?us-ascii?Q?VQh4FjuIa2gq6NBrqN4lYC8a6eCW9Sc0V9QhXG1tx7Q0qFCamAdzGQptcE+d?=
 =?us-ascii?Q?QVCbGIkNkDD2MvouallWEZvWvHrsaiTfNiMujIoeX2S84daLkh8nqoPOvWR0?=
 =?us-ascii?Q?NdoT1VCb0c3TK/hOIhg1mI69zk9aQMjIFOEhpZJRMS/loAlhk8iehgsO9+Os?=
 =?us-ascii?Q?g5tb7kleMO72g4hoPxHLWKVBbH2nERacrVuuMnkpiheSLKSvxWhRu3Z7Tpwl?=
 =?us-ascii?Q?YZweEBHkd1p/xcbK5jqwYemwn/MktGU3AjZFc6M2X3ikYE8ZZfswypJORpKO?=
 =?us-ascii?Q?GOlvoYE52AYcPKBtBYNfVHWxG1eRHubteUYej4Gz5zKDKzx5k0Ao6r1inl8O?=
 =?us-ascii?Q?kbb2nrja2sL0fGOmJS1IR/ygr8iiusZFFPlXUsmzTwm3jMmz3uRiY8wWc3uH?=
 =?us-ascii?Q?4HaXiLDL0r6zX3v1bTr3ctuD/UhGsusftMkyN4OUW7XVkL6jNByDvadPWd5d?=
 =?us-ascii?Q?hy/A+Dq025l4oLLBm9iy/UBjeYRsIo/hdYUquTktbetsvM2XdFHz5XL2qJFl?=
 =?us-ascii?Q?xdPRoOta/38QvqLFpnHdRswSAxcL47DglbqjidnUJoBLkUpC21l1b7qFg2K5?=
 =?us-ascii?Q?wAmIBfnORdt9lJfM6BY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8705f8ee-4540-475f-1767-08da82149fa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 18:57:11.5806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hSnuS7VGWMgC4sdAjomT3Nri0dfFBA8+7MbsGXx2aKLrvVOTPZL7K/hZew9OOOi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1853
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: W6J4TelboVfCQrALU8y93pDk0PY6AlEy
X-Proofpoint-GUID: W6J4TelboVfCQrALU8y93pDk0PY6AlEy
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxscore=0 clxscore=1011 adultscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190070
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> -----Original Message-----
> From: Kani, Toshi <toshi.kani@hpe.com>
> Sent: Friday, August 19, 2022 12:49 PM
> To: Justin He <Justin.He@arm.com>
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> edac@vger.kernel.org; devel@acpica.org; Rafael J . Wysocki
> <rafael@kernel.org>; Shuai Xue <xueshuai@linux.alibaba.com>; Jarkko
> Sakkinen <jarkko@kernel.org>; linux-efi@vger.kernel.org; nd
> <nd@arm.com>; Ard Biesheuvel <ardb@kernel.org>; Len Brown
> <lenb@kernel.org>; James Morse <James.Morse@arm.com>; Tony Luck
> <tony.luck@intel.com>; Borislav Petkov <bp@alien8.de>; Mauro Carvalho
> Chehab <mchehab@kernel.org>; Robert Richter <rric@kernel.org>; Robert
> Moore <robert.moore@intel.com>; Qiuxu Zhuo <qiuxu.zhuo@intel.com>;
> Yazen Ghannam <yazen.ghannam@amd.com>
> Subject: RE: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac
> from loading after ghes_edac is registered
>=20
> On Friday, August 19, 2022 4:35 AM, Justin He wrote:
> > > > @@ -1382,6 +1395,7 @@ static int ghes_probe(struct
> platform_device
> > > > *ghes_dev)
> > > >  	platform_set_drvdata(ghes_dev, ghes);
> > > >
> > > >  	ghes->dev =3D &ghes_dev->dev;
> > > > +	set_ghes_devs_registered(false);
> > >
> > > This does not look right to me.
> > >
> > > The condition of using ghes_edac is (ghes-present) && (ghes-
> preferred),
> > > where:
> > >  - ghes-present is latched on ghes_probe()
> > >  - ghes-preferred is true if the platform-check passes.
> > >
> > > ghes_get_device() introduced in the previous patch works as the
> > > ghes-preferred check.
> > >
> > > We cannot use ghes_edac registration as the ghes-present check in
> this
> > > scheme since it is deferred to module_init().
> >
> > What is the logic for ghes-present check? In this patch, I assumed it
> is equal to
> > "ghes_edac devices have been registered". Seems it is not correct.
>=20
> Using (ghes_edac-registered) is a wrong check in this scheme
> since ghes_edac registration is deferred.  This check is fine in
> the current scheme since ghes_edac gets registered before
> any other chipset-specific edac drivers.
>=20
> > But should we consider the case as follows:
> > What if sbridge_init () is invoked before ghes_edac_init()? i.e.
> Should we get
> > sb_edac driver selected when ghes_edac is not loaded yet (e.g. on
> HPE)?
>=20
> No.  The point is that ghes_edac driver needs to be selected,
> "regardless of the module ordering", on a system with GHES
> present & preferred.
>
> Note that this new scheme leads to the following condition
> change:
> - Current: (ghes-present) && (ghes-preferred) && (ghes_edac registered)
> - New: (ghes-present) && (ghes-preferred)
>=20
> The option I suggested previously keeps the current condition,
> but this new scheme does not for better modularity.
>=20
> What this means is that if ghes_edac is not enabled (but ghes
> is enabled) on a system with GHES present & preferred, no edac
> driver gets registered.  This change is fine from my (HPE) perspective
> and should be fine for other GHES systems.  GHES systems have
> chipset-specific edac driver in FW.  OS-based chipset-specific edac
> driver is not necessary and may lead to a conflict of chipset register
> ownership.

Currently, running with this on the kernel command line
	ghes.disable

causes the ACPI ghes driver to quit early in acpi_ghes_init():

  /*
   * This driver isn't really modular, however for the time being,
   * continuing to use module_param is the easiest way to remain
   * compatible with existing boot arg use cases.
   */
  bool ghes_disable;
  module_param_named(disable, ghes_disable, bool, 0);

which results in the skx_edac module assuming it should run:
  [   33.628140] calling  skx_init+0x0/0xe5a [skx_edac] @ 1444
  [   33.628531] EDAC MC0: Giving out device to module skx_edac controller =
Skylake Socket#0 IMC#0: DEV 0000:36:0a.0 (INTERRUPT)
  [   33.641432] EDAC MC1: Giving out device to module skx_edac controller =
Skylake Socket#0 IMC#1: DEV 0000:36:0c.0 (INTERRUPT)
  [   33.653256] EDAC MC2: Giving out device to module skx_edac controller =
Skylake Socket#1 IMC#0: DEV 0000:ae:0a.0 (INTERRUPT)
  [   33.665055] EDAC MC3: Giving out device to module skx_edac controller =
Skylake Socket#1 IMC#1: DEV 0000:ae:0c.0 (INTERRUPT)
  [   33.676801] initcall skx_init+0x0/0xe5a [skx_edac] returned 0 after 36=
343 usecs

We might need to differentiate between the system ROM really not
offering GHES vs. the ghes module not running.

