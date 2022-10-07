Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE225F7DA4
	for <lists+linux-efi@lfdr.de>; Fri,  7 Oct 2022 21:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJGTLB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Oct 2022 15:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJGTK7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Oct 2022 15:10:59 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5283BE1E;
        Fri,  7 Oct 2022 12:10:58 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297FLvf8013420;
        Fri, 7 Oct 2022 19:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Hjk9FZnIoQYjgnY2eutwVy2SxW/Zr+MFfqZgRDrPZjY=;
 b=XZOUOfcsBNjHg4ET2Rzynrv56OIrtn/cohPDFRuYCoH+6rQQCmjrQ4WZg4X65y2hEFh3
 1gTc4pCRI5avRi/jas+rtfDDOWzc6qWBYv9EJdhOodnn0dQKtxyrxz24bYaeziw3ZY+x
 2v1dzqBL4uR2kuRX5AeGaItLMhqO2Ln7zpihgNj9kaRKvlYYOX/ZcpS9gU3DdFmLrJaX
 az4+OS1+ATq+JlWvu1bPhqKyyViwIJ9ml87FSyAKMLd/ur3dhkSZ9U1PY3+NAQdAozLX
 zEhqyLj/hXwwlzE9e0EJ6WFkDvWT418rzas+mipe/NiBj6wWs9qBWZhNvgp1b6ccdgnA pQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3k2pgqhmgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 19:10:20 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 68178801AC8;
        Fri,  7 Oct 2022 19:10:18 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 7 Oct 2022 07:09:58 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 7 Oct 2022 07:09:58 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 7 Oct 2022 07:09:58 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zy5lMHVpjmLGfQb47TWD2xlSnA6vGU8wETpi7ofCDMmrNVqgqq7MVIzTV6CXabhIpA7kj00nHPoRfX05SWe/+cbsrkM2j5rnUgZmz/gXC8JGt2Rl0CBpXTVgB3VG1eC4o5ybguvwiTghwTwAxKY52AMN++/S2ol/dflHCu+TidO2+Sg6boj2ApD3ooEPOwJHmTOYQGrCrjta0mCCXKyHs7FNA7aixH6fT6IeLpjEPEbkWlMD5y8hbBNFZOwYFq2eirPBt5jRnBHy7kKGNrY9u7DcvZQLahaustRzQ2PJ5OahQDG/h1C8izhUn87ikRm8NivGmcGrxt/JvSurcbO5hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hjk9FZnIoQYjgnY2eutwVy2SxW/Zr+MFfqZgRDrPZjY=;
 b=brUrD9LqjsuhQgfo94nzJ5uJyeSXfOBrtsU8CVLvfcAKKaGrLrPNGoD+5UJQPsW1QpMX5pHtUh77NF+0ZJgcw92plTjJJQqcISPQJzwberjSQQRGSOgwr/iutbTzwLE4cYr0T+fyVTmjqMe4iX7qUQ8O5qvLTbVSAghi9uYi4Rz9JVjq5Mn8JvoJd3jIEWqHjsg4zks12fHkSDMttQt2YEolIvBAxsjW0hqQ7ZO6T+GKUVC9PHlXUUBZZrI5LNjTK2dE1iCmx+Z/PhJ0JwuM0G4icwNAaxAS8xXlLPFJ6o6bDHbmylGUmyvTO8IADd973/oKGoqpuHf707zuH8m6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH7PR84MB1367.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 19:09:57 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 19:09:57 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "gjoyce@linux.vnet.ibm.com" <gjoyce@linux.vnet.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>
Subject: RE: [PATCH v4 2/3] powerpc/pseries: PLPKS SED Opal keystore support
Thread-Topic: [PATCH v4 2/3] powerpc/pseries: PLPKS SED Opal keystore support
Thread-Index: AQHYtBuYHxybhNKpcEqM4K4PklqiZq4Dl1pw
Date:   Fri, 7 Oct 2022 19:09:57 +0000
Message-ID: <MW5PR84MB1842689FD13382CAFCC260D8AB5F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220819223138.1457091-1-gjoyce@linux.vnet.ibm.com>
 <20220819223138.1457091-3-gjoyce@linux.vnet.ibm.com>
In-Reply-To: <20220819223138.1457091-3-gjoyce@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH7PR84MB1367:EE_
x-ms-office365-filtering-correlation-id: 6c643326-8466-467a-776d-08daa8978628
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ymY9Yd98yHgodqcpFIPfOZqQ5nw9CQJ+rs30hJYvF0d+CpcjwoYXvjQwcf1tr6Pa+p/9e8lkppVH4M4NNQsXpaV1QQizB2ITaDDk7e3NKbrsh+r3dzg2iGr9SIIcU7axwk8esit+jSMZ25Zb5oj8J8YrX9RgVmmf6vTJ40omJNeSed036XLO+bu23Husrqg5m0XTGSLy4mT1rZhl17vIx9ZIsk1grx/KRtQ7P7kcp6L/vhKNaeThmP3N42MM7rs2IsYLGsK2KEYHXyQux5ZXeHbZ2qkgMyoeYAFm+YI/6uZ8xWPuzCJNjeMgXhliWhOiHF72/Mf4a5zLKxkE8VUHD4kF05BMlqNCmWxQrcakNNMk8wUCyPjzD/ok8hjOXCun0WpKbLVcqWcW+RSYmot6Bq62OnabQZMTwwxW7yrzklIU7vAg66XjDA5eJPd3D22TEyAqcQQ7B0ISv0K+R/3GlkEoS+cwXAGYTvTn7FJw+DRcZdvFTW7BJvH+D8GUc/da7tZUgZnx4F6Uv03000p/xLgbi9Yg0CUl/DFcPSeNGG9vU7iisfBeOLsWCqGw2Tn4FY+zY3CkL0f0hxVAZBNVVq9LTwH6TtNtERKDiZY7SpclU/6yi5uJHsaKoGRY0HuaAuOegE3wO/ODObRzF4V0QW40+ph84KOBVoOyH7cCZJw+G86HjpQvSEawekGMvMBZtdhhb5VFpKPkHVVJtDIVclg3dLNNmSGfjegCTVS7l+PeS0Q5wld5Y+UxoIozBIkJdeUxQC2juNx51n8+pduAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(478600001)(9686003)(6506007)(7696005)(26005)(76116006)(55016003)(66946007)(8936002)(52536014)(71200400001)(41300700001)(2906002)(7416002)(5660300002)(38070700005)(8676002)(316002)(54906003)(86362001)(66476007)(4326008)(82960400001)(33656002)(110136005)(38100700002)(122000001)(66446008)(64756008)(186003)(66556008)(83380400001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ERClSJGwGfS46sRZdbi3xo9R54NLA7a4YxSOkJBQWP/cVeqq2egvvvwQIDhL?=
 =?us-ascii?Q?Ht1smNUbrkxnt9FzDzZbLjcU7iO7VStPVSOaB4EskL69pF7cD1v2iOSCzl/m?=
 =?us-ascii?Q?xCVTE5hdbRHZbv6UjlETPVi14CeC0flVqaGlfah8XQ8yh8Ufe9w4S9dB2YBn?=
 =?us-ascii?Q?9elTTntomNtb7h0X5tsza0tgKzjIiYj7pjxcRQt32USWbPgxdC7nT1iXxfUU?=
 =?us-ascii?Q?iTUc3kxPKT6jFFKdbkf/OJPvgyN2rXDc2evGuAkAAf0rx0Cokvp+2Fx5cTvj?=
 =?us-ascii?Q?ZKw0wgrOYx1cBGIvQJ+ChHOa52qWj4XiWNn/OFEGnBFRQ2i7otOX45DCzMf6?=
 =?us-ascii?Q?ms1p7e2IG0Enx/T45A04greSn5G65PtS5esNipP+C4TmeUKqHHL1Wa29BFWR?=
 =?us-ascii?Q?zm0FEPpcYXlFg+gVlSzYmbv0IGI0nx4dP0x1oThhNP0N8nGzZmAGzD0qLZ/2?=
 =?us-ascii?Q?N+lHoyPbU6IrhRnK6kK64i1yaFMuXfL+fG15+imLwtnHvZfAgAcZ/u/NJzQI?=
 =?us-ascii?Q?6hGNSKUlpPg9nQBKSPEyGmtQNH60OGYKbzFyVJMJsrY0LmB/wfUnq+f9hYib?=
 =?us-ascii?Q?b29ZJEoRaVP0/nC67mRpcGTdjJvr5NEMHKVLyNPcG0ABt4rivrFxk6Qnaipy?=
 =?us-ascii?Q?qjJiNaJlYhUPT9cWws0sGN+fqo+nYDAbvquhVxXWBNyWMnMUFIwZ2bCJus8F?=
 =?us-ascii?Q?DwWrA/D1QP3tDyHGmpjVhn1ISDhdRwa+7rFoGzAjykSvEsb02SVrpLBrqZVD?=
 =?us-ascii?Q?boaGeSelwrRBYzCFXrJtjSo2V3pVEPaOJBhp07bsjDnq2oim5T/wVSn/UXFk?=
 =?us-ascii?Q?t/UQ+Deas+8KUpvtX3QG0s0dnmqX8Tg6KsleJWlHeE6P9VEhvjcdluhWdGPB?=
 =?us-ascii?Q?BKGAWYBFs/U88ouNHJMx6KEq89PSpjcdYYTdB9jZrCbmAqGzvI5mv68gSqok?=
 =?us-ascii?Q?Q+QSyjCihjt9GxqK4SB8i2JYs47OBzyGf5hbgrNq6wP9giEQM/uATuzyVDfs?=
 =?us-ascii?Q?EmhcUJTaPzOv+t0ojsm9oOXDjykBkTGfQn8FC4ShWizXqXCQ3g4ioOLhVBHj?=
 =?us-ascii?Q?fWdiPuSZVMf+JPnyxKjgF7H8gJp4+mHn27pKaNAwXVk2Rp1QeevJB9uRqj21?=
 =?us-ascii?Q?mFChtgJzNW2zKVeGDuEXuYzO2QB69bLVvF2+889bxxvyQUwihUx1o3RrdSif?=
 =?us-ascii?Q?qk4Lc89hk822wk5CUifZ98izIHzahB+MumbcIObD8jBbAsKzjniK92p4bXqg?=
 =?us-ascii?Q?BGenvMnj6pW+ZgC4tZbdObBu+2XYrFQZ3ByhojM1/dBr5A4WsVc8dFfpZSVP?=
 =?us-ascii?Q?h2N19xdy2uCzFJkwuRtGIeUtcxh5cq8mtHdEuhqxseX/QutKE/nPSe+titLf?=
 =?us-ascii?Q?JrejH9DATRz/gqsYJgNS/UnRUEtAxnybfNw66p1SHTSZf3TuZLu3yQgHK4Ru?=
 =?us-ascii?Q?uG7X1HfCRuLrfK3cwM2XCFxG9ocOArVHTdZNut3BM6lHbnO8mf5Hk/Tumz3M?=
 =?us-ascii?Q?SEJVr1cjcYbhGc5VhqG0/XLhuqBqtr8bqyy1UwssMQ6tBmYeZDyM1mukX4RK?=
 =?us-ascii?Q?MXru5WZCU+0CoSr1OHs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c643326-8466-467a-776d-08daa8978628
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 19:09:57.0204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eie2na5FMEqcD2mRq67UZCy9P+qfjV+TPaqyNjqZWHbZVeohAPZTXSRxJu/YS7RY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1367
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: G_fmvSBEw2lgs0SuLQdq9l5mzLJAvuss
X-Proofpoint-ORIG-GUID: G_fmvSBEw2lgs0SuLQdq9l5mzLJAvuss
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1011 mlxlogscore=980
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210070113
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> -----Original Message-----
> From: gjoyce@linux.vnet.ibm.com <gjoyce@linux.vnet.ibm.com>
> Sent: Friday, August 19, 2022 5:32 PM
> To: linux-block@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org; jonathan.derrick@linux.dev;
> brking@linux.vnet.ibm.com; msuchanek@suse.de; mpe@ellerman.id.au;
> nayna@linux.ibm.com; axboe@kernel.dk; akpm@linux-foundation.org;
> gjoyce@linux.vnet.ibm.com; linux-efi@vger.kernel.org;
> keyrings@vger.kernel.org; dhowells@redhat.com; jarkko@kernel.org
> Subject: [PATCH v4 2/3] powerpc/pseries: PLPKS SED Opal keystore support
>=20
> +++ b/arch/powerpc/platforms/pseries/plpks_sed_ops.c
...
> +struct plpks_sed_object_data {
> +	u_char version;
> +	u_char pad1[7];
> +	u_long authority;
> +	u_long range;
> +	u_int  key_len;
> +	u_char key[32];
> +};
...
> +/*
> + * Read the SED Opal key from PLPKS given the label
> + */
> +int sed_read_key(char *keyname, char *key, u_int *keylen)
> +{
...
> +	*keylen =3D be32_to_cpu(data->key_len);
> +
> +	if (var.data) {
> +		memcpy(key, var.data + offset, var.datalen - offset);
> +		key[*keylen] =3D '\0';

Is there a guarantee that key_len is always < sizeof key, or
does that need to be checked in more places?

