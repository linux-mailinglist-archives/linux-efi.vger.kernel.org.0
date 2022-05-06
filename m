Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B74C51DA62
	for <lists+linux-efi@lfdr.de>; Fri,  6 May 2022 16:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiEFOWF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 May 2022 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiEFOWD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 May 2022 10:22:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC27322BC4;
        Fri,  6 May 2022 07:18:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBp4NxOGkLGsk+fc50vjzBpp88WHvERcS1sEVSxrYw5fn2tRp6ZcELVMeJdIvhY9u4OxfJPpml60LyzDXHan4SBvuf04T3JdKg5cYJqkb8ntgMnx0k+gND6FMHDHlvdxyXEpH3dzw1iI011NazWXHxI7K1z0Txwfnv7xQd0qjWtXTiD3OJu9EK40gfPJKHd1rKBxT7sxKzr8GKvcxy8Cn/zI5XZOlegcg/RdTP953GGaC3y7yUO9OL51sJQXTlTuUDAenKc8O6Dvm+aEjJ32DjOzlOf0hOJdOzEhAr4MnfJ4eIsZWR+9a/cpavpfZsoOVWVJ7pKCLJJRUJ3V4eW4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kO6iTHdkfcJQ3BmUkYYonZRPLHrVwBoqx6JNEnahac=;
 b=TTvKM0rJIKQllRpRCnj5JyCAx8OT8oRY4nd0GcON9uCkU+A+YaL/RyuUv7j/HBUU4srscw5xFJq5Qn866Shb21ResGMJCw5fenhY89pQx9/sGhAYfoZzGe5WPm4oLnJpMaqz34zERx0sILWisQ309BhGS558kmSANLhdWvsm1KRGKF5dhK3IvxB8ghQP4VJrDY8eU7RDPZXQ5MZtnVrfWFhJhmPlODIWE8xFjdxxzCCNILE8EdHC7c1+b91ofFmuSbjpLZFMmn/t/6JsKaruAfNnRg8sLsOb5HI39n3dLAhAn1UfWtEUxf86thgkQIoXPoOx44DBS6TDMHGbMsiI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kO6iTHdkfcJQ3BmUkYYonZRPLHrVwBoqx6JNEnahac=;
 b=eGTBW5PF2G4byR/gXlc6hGQ0/M2VVcxyjpyvdVJxlvY7KUro5iAXOwL1uTbM3lPX4HOgaGpYchk1moh32YnITWN05DIXSW1cIuWzN5MsQRfJk0aMCcs+IztsLatZxgqmwhFuNBRFUQNuMnMQ7xOlDIYTfwTT6W2icDIwtdv9f7A=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 6 May
 2022 14:18:18 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::1134:e908:ed64:d608]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::1134:e908:ed64:d608%7]) with mapi id 15.20.5227.020; Fri, 6 May 2022
 14:18:18 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        Martin Fernandez <martin.fernandez@eclypsium.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "daniel.gutson@eclypsium.com" <daniel.gutson@eclypsium.com>,
        "hughsient@gmail.com" <hughsient@gmail.com>,
        "alex.bazhaniuk@eclypsium.com" <alex.bazhaniuk@eclypsium.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>
Subject: RE: [PATCH v8 0/8] x86: Show in sysfs if a memory node is able to do
 encryption
Thread-Topic: [PATCH v8 0/8] x86: Show in sysfs if a memory node is able to do
 encryption
Thread-Index: AQHYXAZUDKYHKedN7EiMgEzSJgmgnK0O8qmAgAALPQCAAtgZAIAAGO+w
Date:   Fri, 6 May 2022 14:18:17 +0000
Message-ID: <BL1PR12MB5157B790AB125DFAE1855067E2C59@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
 <YnKr+aMf4PspDpHZ@zn.tnic>
 <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com>
 <YnUYLDjIThbIz/Uf@zn.tnic>
In-Reply-To: <YnUYLDjIThbIz/Uf@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-06T14:13:45Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1f1197a0-31f4-4d83-9bcb-51331fd4a60a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-05-06T14:18:18Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 2877d0e7-219e-4e21-91b5-141d4c451f43
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da1331dc-16ff-4b7f-47b4-08da2f6b4449
x-ms-traffictypediagnostic: MN0PR12MB5980:EE_
x-microsoft-antispam-prvs: <MN0PR12MB598083AC8488069A4308D758E2C59@MN0PR12MB5980.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VCGEq7GuBY6y95urZ43e3DIQEOGzdSpmrDDA5+Nn69K2hiMRJ3fLEfILhtD4G2hnOEn32GIpE03S6FWJXFTV25OQzJt1BGibftJX/AAecujh1UodxOj8uYbkcl8iH9SGdMWuxDYHK9Et8ZtFYSsRVP/YyZ0h2nUFDW9PSeZcC8iTz5kEVtyFngrGwG0IY8ESL84BQrjXBA2xIiQNghwBn94kIPt9lHNUmLkV8lpqWsi2cL51l/AtE1Dq6ylorqV61hXm9S3Daw+tUTJSyiivGa/L+gQ17RMa2dAEkHhzRWDJm1jD4suDo4cm7TvNgpADVj4v5Yn/SpThP5ZBtDIwHuGodoZqKHTyKh7RHei8SB4HXvUTkXTDwM8xu5C3TgiukkHWNCUscO/ROJ1/pZVOmvs3qFiggGaxn1eKgq7zXynyvtyyu3JHz14d/xz5Rz2ILd/aYbcoS74iqcFgRw363f5udUDK2WD/AHS4Lc8FpVkdmMvbPjCJ9qP/tAJJMjMCUen63IkCNCdbQcAJ93xmeO3Bzt1zkJU8qjSKqhMAvr+NELPf06V3tlFDu3eI0ydWCikQ/HwJhwcathHNKRtdRJG5NwSjbmno7/Wv68SDvyF/RR8j6/PCiofkochc4Lc2FjU/DZK7xsk3x2k1QmdMET8kNd8IWZV5cf4XmDfSvnYBBWuXcR4+4oqEDtB/6Yoe2WrkhZTxYwD1uNHO5REuIIpkLAJ3j31jZevwQxdblrNtsCH+oJM3zXaVp6xqbPebcNaaUG2DjmBFY6BZqMdzmlq2JfhEPHUaKWJ0nvQafkA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(76116006)(66556008)(83380400001)(7416002)(8676002)(66946007)(66476007)(66446008)(64756008)(86362001)(186003)(71200400001)(6506007)(2906002)(966005)(5660300002)(508600001)(55016003)(316002)(38100700002)(110136005)(54906003)(8936002)(122000001)(52536014)(38070700005)(26005)(9686003)(53546011)(7696005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KDZDW+TjFSAMGyu4XZh15O8qXQMjKKYSHC/DU4lr72PxM5F0//noKkM8ExV5?=
 =?us-ascii?Q?stGGz9UVCMggL1qKRfKLsY1CgKyttmSm2vdifdDXBaZ0+1P6MqemzCX3sarS?=
 =?us-ascii?Q?barnKMjEMPbyKnOj22TuIHxZIyPupIqKCGKy23pKPF8RTdZi89zOTnogBFk7?=
 =?us-ascii?Q?gl8K/oGozaehje/bFWf4EM7OlXVaim+BpEPsC+PmPFV+m6pgvtZfWdXK4RLa?=
 =?us-ascii?Q?02AsFUDSYkGE118K/REm8VRSSAR9pdR7uU0WnhsWtz+yg+3tsR9lByTWY3+s?=
 =?us-ascii?Q?8fF6Gao0/54lOya19/VpLifEgWMB/RIggY4acyzySPPWXg05vGmE7AsIFN1h?=
 =?us-ascii?Q?GfKHObYMUaQuh/LrynQ/S1fFusA0W+3qhEcpOw6NcDl8wKOZ3FPYcuTDf1Xk?=
 =?us-ascii?Q?YOuw5xGaxw6SQ6nxLTXzZT92efKrBVNd1XNfiCqkvmhS+GW5m3H8h/UzGiw5?=
 =?us-ascii?Q?Q2eTqiMhXGXeEivYoYjaPfMFL9NnjPHQoN6Dx9OfQzg3OTxDrrqHqTdQWzOc?=
 =?us-ascii?Q?nv8mPJKzc+3/Ayacb42lmzRO2l49WWhctyYaKWF5YR8BAZhxjVwNMwZGJDD4?=
 =?us-ascii?Q?iYsJWcPF6nHi+lWJCh8UZEC2FNw6vg1FdsQHCBvyabc4zTzp2D3qdb1t3TL+?=
 =?us-ascii?Q?VShAog91PHIXuKFDkopkPJAgQzAPmKmIeeLSeoWjAwQPkdCHmlL7ewbCvhUf?=
 =?us-ascii?Q?SStJRuTenOmuqRebvFlypEHJCct34oG0KzORBLu8u1J4PNI2GVMKGpz90nRe?=
 =?us-ascii?Q?Eck6eYTEZ0pCKTKUf3uBIsPJYnAGJ88pfuTWbV/hNIQ8ZlHq28XJ6NTqMeCL?=
 =?us-ascii?Q?vd7JA0TOdTCKESh36KBHtOXpp02ZVQAIcPnMz30fOwLqNSPzVmG/sD9XMBq1?=
 =?us-ascii?Q?cpLsUoSqYyOpbkiUsa5u2PV2SllzKi6EOs1P7rsZOr7jVpF+SguJusNYNmzs?=
 =?us-ascii?Q?joL02GsXbt61TzIAFraC9IqArh4KZHJujsCa+yoo7sD8pZtXRdT14J5BUsAx?=
 =?us-ascii?Q?XSDVeL0ZElIgzAHXQRTd647Mc0CaNvzQm1TlI5trXE1F26iCmJkHcKy5cco7?=
 =?us-ascii?Q?LGkfy6+ij8ObrPk6YcmaftVDAx7YkqU+byPGto26xVMiKA9zLK9iBkHrITHj?=
 =?us-ascii?Q?IWB6MHjb5s+n0c8+CSMQPNGEP15/n4wouu4pTbxLHpmqZpTfgRCfdNZ4XLhz?=
 =?us-ascii?Q?k1CWll31NRrlpp5i4T86JeJeh22N4AysbDp/3tjCjmOkXgm0X6xW8NaTDC23?=
 =?us-ascii?Q?KLY+5EHt5e+tO5bdWa89i4GDLxnSvndjkvr0FDBRGFAPGBA0jAdGjE5R7fFs?=
 =?us-ascii?Q?oulDEOyEYchR4U2E3KO+mQn/SpZErSsq4MuzP0PU+VX+nL0q9ygOoJ3edAo4?=
 =?us-ascii?Q?TkyEGF9cylt69TixsreC4kS5107QKEsC8afLRgtbYckDOo4s+FWex5bXUzOy?=
 =?us-ascii?Q?bo42qOoKqxvGcDVkOg8rFJu8KYuqe300qsnFmPN5STaASqy5zs3CThfNtWF4?=
 =?us-ascii?Q?47HPDWhneNKlypvCxC9colsxijF7Escb4ZhvdcrAqgqx29DssDz73bXoIHfH?=
 =?us-ascii?Q?mq0+AREt5rKtMIlDVFBx7YRrTaMcBUH46frOBVNuyMH+KfrZz7nifW/iYctl?=
 =?us-ascii?Q?RecgUgwPGt5mDobqgm1WQWgwa1jMOsQ4VE2WaAkynQZpaDWrnNn/fV6K8PcD?=
 =?us-ascii?Q?bVogcAkdIa/EOi36+CyrV0jcIUKIQCZjEEeIPrWJ5LYbfBF9hJHpNJcep3z8?=
 =?us-ascii?Q?k4OggffbLw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1331dc-16ff-4b7f-47b4-08da2f6b4449
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 14:18:17.9537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qzz8aX34ojsvjirGuhcr0X7yi0Dy2IzQjCgL33+sEAuzhOxk1wyzGUwjRgfArjNjZamSF+Jgc1+QxNCA4FMqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

[Public]



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Friday, May 6, 2022 07:44
> To: Martin Fernandez <martin.fernandez@eclypsium.com>
> Cc: linux-kernel@vger.kernel.org; linux-efi@vger.kernel.org; platform-
> driver-x86@vger.kernel.org; linux-mm@kvack.org; tglx@linutronix.de;
> mingo@redhat.com; dave.hansen@linux.intel.com; x86@kernel.org;
> hpa@zytor.com; ardb@kernel.org; dvhart@infradead.org;
> andy@infradead.org; gregkh@linuxfoundation.org; rafael@kernel.org;
> rppt@kernel.org; akpm@linux-foundation.org;
> daniel.gutson@eclypsium.com; hughsient@gmail.com;
> alex.bazhaniuk@eclypsium.com; alison.schofield@intel.com;
> keescook@chromium.org
> Subject: Re: [PATCH v8 0/8] x86: Show in sysfs if a memory node is able t=
o do
> encryption
>=20
> On Wed, May 04, 2022 at 02:18:30PM -0300, Martin Fernandez wrote:
> > The use case is to know if a user is using hardware encryption or
> > not. This new sysfs file plus knowing if tme/sev is active you can be
> > pretty sure about that.
>=20
> Then please explain it in detail and in the text so that it is clear. As
> it is now, the reader is left wondering what that file is supposed to
> state.
>=20
> > Dave Hansen pointed those out in a previuos patch serie, here is the
> > quote:
> >
> > > CXL devices will have normal RAM on them, be exposed as "System
> RAM" and
> > > they won't have encryption capabilities.  I think these devices were
> > > probably the main motivation for EFI_MEMORY_CPU_CRYPTO.
>=20
> So this would mean that if a system doesn't have CXL devices and has
> TME/SME/SEV-* enabled, then it is running with encrypted memory.
>=20
> Which would then also mean, you don't need any of that code - you only
> need to enumerate CXL devices which, it seems, do not support memory
> encryption, and then state that memory encryption is enabled on the
> whole system, except for the memory of those devices.
>=20
> I.e.,
>=20
> $ dmesg | grep -i SME
> [    1.783650] AMD Memory Encryption Features active: SME
>=20
> Done - memory is encrypted on the whole system.
>=20
> We could export it into /proc/cpuinfo so that you don't have to grep
> dmesg and problem solved.
>=20

Actually we solved that already for SME.  Kernel only exposes the feature
in /proc/cpuinfo if it's active now.
See kernel commit 08f253ec3767bcfafc5d32617a92cee57c63968e.

Fwupd code has been changed to match it too.  It will only trust the presen=
ce of
sme flag with kernel 5.18.0 and newer.

https://github.com/fwupd/fwupd/commit/53a49b4ac1815572f242f85a1a1cc52a2d7ed=
50c
