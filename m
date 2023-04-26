Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B636EFCA4
	for <lists+linux-efi@lfdr.de>; Wed, 26 Apr 2023 23:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjDZVun (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Apr 2023 17:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjDZVum (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Apr 2023 17:50:42 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FBFE45;
        Wed, 26 Apr 2023 14:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyuvhxKTWah59OUOUs/SMQygAyiVYi6/wWIjcrE1rjHUsF/yHlmAvAJipwUU0tLZlIiFMYqdT9+0ps7lt2x3YYZY9dFUoHgVKj5wPxtVgpUN5h9wOfdJY7Ld/UEfpPmHXqJ1c3iecPL3paeARrxgH8jZaoWtC5ksVob2TyLs/hCvyKx/OnXdeTO0iVqQTp/+s5Al9HwmhpsSyQtrgRigvH/XmJuzLol0MpD4k+7SOpa8/+0lWc9uRXrP5b4hHdp0RIvH6Hxds6VjID7oBnCjUnzNs6mampadQajFSpGmssQw9zTJrX8uRM4/qYwSPS8uLRwq3/RjoH7BQDuTEJtrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdRTUNRfCuBAZszVfz0ngcsjrITs+8L/Ktp/taVsU8Y=;
 b=hrroKbd4KQEs+TBCc1+WmYJW01wJxgoOnx3KB8JyVwgDZXfM0hKNHZRgOzSoQ0P0dn7In4C8HcPoK2QoWwi+BBboemzJXQSwjcGi0Y4TLdANaEWNLwsZRdBM92poExLBFR0Vn65WYAO3B9OL/IaJ+8Wjdb6iYF0HIZNzBi8hFm5VFoTGoGmO5ISVcWLspm0DPwGhBFblI+H0yKAAymsiGuFFsM4HJdo1oyyXKHMWyfJNu0EB7odTYYWepS3Bw7DRSGgoIKRvgIid0mNz6wbODTg8Luc3gxh5TQnAfTgCuwPcv7A1/qHIxUWT0k0wPjNH5H1bvE4DJW2N6Fnz1x0XAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdRTUNRfCuBAZszVfz0ngcsjrITs+8L/Ktp/taVsU8Y=;
 b=AgKaQ2d8oK3BV1H133n3ICSC/qExHhEC3SRizPZYRjAz5Yg7CmIJJFjgidnjO2GxjJP0sQbT1I+Rhqr3TEfEcopZVLIJ+aEL61sgyMEiw6y7oXxnoMXJ3n/XOSIiCuv0SDxi16rxL5nckRC5XFf5HBcsZNUcOMH4Q1bZk+Z86d0=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 21:50:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 21:50:37 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Anisse Astier <anisse@astier.eu>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jeremy Kerr <jk@ozlabs.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anisse Astier <an.astier@criteo.com>,
        Richard Hughes <hughsient@gmail.com>
Subject: RE: [PATCH] efivarfs: expose used and total size
Thread-Topic: [PATCH] efivarfs: expose used and total size
Thread-Index: AQHZeHmUtN8GhECaG02OKK2EPOLHv68+IQRw
Date:   Wed, 26 Apr 2023 21:50:37 +0000
Message-ID: <MN0PR12MB6101768A09C5C2C78C2B9B58E2659@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230426195853.633233-1-anisse@astier.eu>
In-Reply-To: <20230426195853.633233-1-anisse@astier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-26T21:50:36Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0846ac4b-0bac-4777-8145-ac9f87ee12b9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-26T21:50:36Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 39ee30c3-0140-480b-b848-d15d9d0045c7
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|LV2PR12MB5845:EE_
x-ms-office365-filtering-correlation-id: d3ef41f7-8a8b-4fd1-fcc9-08db46a04573
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NHXgKjUO12m+FDuTEn+lKC3Udbw7MAUOmn6d3VP0BzUUzhUc+SCfQW8UTuLXv6R0V0e3n7rhLFDzDa0lcK2WhOJOrU2F9cpHsCNYep7qqPP3nz8j+jpSoj8DaczSWoUjb+cpx+Y4dAyYkR1QiEyvHvKAeqshaR7ExkeIJz7FBVuQ5vvDpc9/DBzOEP3Fg52IIU7ddfw+//SzkSYRgfg2QpvfMxqMxZ/+G/HNogFpiJB67m6IkcssHFjUxkaCo7dnowJnkzQ8Csp47heGN4OJ8MLcUuS23YlbBVwnVR3bT1GTSj0+2ljzLP/q4CnJgdlk7680ErRIinCA1FmHWDsIX6w96FYRccs7BGDD+X5hrBNITCm1ZrldG58dI8ko3VIweQaCq6pIZzCmQo5q/jmmwyWVmwGc5y1AXJKsGkAQ29wlTesRvpXO7rus929NvnvcRC8bm8pLNM9qqND4kkSnCUILWQSqM0ulFZj6cF7MhIHVMOzm3xn4ev3/bS+RV5XOa9Tig1fsqKtno7KSwqnCS7dl0zS/6ZHKln3h8BhNrmQyTCkmY8+Do8Yko2yPXpl4mYHFakx7/CECqn3IMW/1nutB+x3YTiMoWCablP1YJEaZSDPZYtCywnFO4YI1Ujaj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(71200400001)(2906002)(7696005)(54906003)(110136005)(83380400001)(478600001)(9686003)(186003)(6506007)(53546011)(26005)(33656002)(316002)(4326008)(66446008)(66556008)(64756008)(122000001)(76116006)(66946007)(66476007)(38100700002)(86362001)(8676002)(8936002)(5660300002)(55016003)(7416002)(52536014)(38070700005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qfLNfDx/oVjGXU7/UipvcbIcfP6VVrLzzuyC0KetzhuOm/hBcgXkSr+rtH/p?=
 =?us-ascii?Q?E1JC7XTrHxN+10ykeVkjEy0QXas/GbQiBgSfHpf4JVyBwlN4UEWVtNiVPbXj?=
 =?us-ascii?Q?AefEOG78gs76xms25TPVbX1VBqDEtBhciCU/DL6CiwffwtdAdVPnxmxzhyIA?=
 =?us-ascii?Q?lUZRbkfWazMYoyFMAtSfVGXClB4IvZq4Q5GUGAWKUB6MH6lDPLUOpbicmCAM?=
 =?us-ascii?Q?DL00uD1S+yQHAsIWOYvt7zBMpScYgBi/kgh8i9ZNrVk0RPYPK/drZZrnreEG?=
 =?us-ascii?Q?ZgxnUK8iABY+8JvkGD2MDqGUX/+TUSLqY2rychcL6dfQ60T+9L/sdpb0pLhi?=
 =?us-ascii?Q?Rapg2l6pY5rBssRsfNDyqbqCnD2ZiMbsC5OG+tsm/a1jmIdyRwVsXYhJXKXJ?=
 =?us-ascii?Q?38Fx7aJZdqopgytUNa+ORIzZpVcnEHdaJ7wUoNWMOnVss0idPT5PWDIbZOib?=
 =?us-ascii?Q?ZfdFHqricdYcQ0Ft+E/VmlipIdt/oEaMKJ+tZxk3tnPkfReZ17OY9FuEw2L6?=
 =?us-ascii?Q?dhiKrZXlRAq0NiTCsKJjFzc7Ar9/UGNSC2/NzLDWkhvTKeeeoTmfo7+sQRP2?=
 =?us-ascii?Q?a9TzINEdn7p/Pc2o3gO3cp8HDR0qBPdWmnQ64MRSdauEL82/NeLWJ+j8H0dM?=
 =?us-ascii?Q?uLo9BUik44uKfGexwnnhODJ5JKqEevsKU8nFQrL4FAOFJrXWl0SNnNFgoV0L?=
 =?us-ascii?Q?oD0yYXNtmg8ipaEXRf1mkMfTSlG27YoXPES2asLfOPxeTrKKvtqAJJ8GQEBC?=
 =?us-ascii?Q?JJoN5tdpVLfu535skd2Z1lphdhQWoN6NreT9kYXBaTBBofyoHJFdkkeFCJI7?=
 =?us-ascii?Q?O+dry+duW34TRAgWQZ6t7whyJ6XMncO/XSXz6Yl1438Ss5b/JEsekQyb5Op3?=
 =?us-ascii?Q?VwqcRT/5eQmDYoFNBmZGtPC47hA+kt1Bn5p7PjSNUN/tG+7eO4C2ci6vsGIs?=
 =?us-ascii?Q?8lYqygBVypk4UGfXqR1cKhnc0e8s0/YvDdWkKmjcsXJpDdIuq7NJcyvqF+kB?=
 =?us-ascii?Q?MdQlBbe+vacTuuN/WHbZLlhl6lEytln1zcTtaBil6DuI8qzW8Z4n0j9K4vms?=
 =?us-ascii?Q?DLAbG6g9Kbcf46j5qgn/YGYhfxoavuN4lbD8oLTrSUHtJ/WH3TikIgwfHIah?=
 =?us-ascii?Q?Jm0rZ8w7dAQV8/7N0iePbVxLCsgfg5lMgiONO6rjR4FbOlHXaoq9aYOCrAu7?=
 =?us-ascii?Q?Oq8t2hcFAPzcj9Vs+Q/7BfJVzJRX5K5n82sENjqq7ebxZ4drQSDba/tRX3vC?=
 =?us-ascii?Q?wcrqm/OY0JDlYsfJ8SpZbj0BGzz01zcCWw/wWtfrYHK2LjzyDC2mbzzb9wDN?=
 =?us-ascii?Q?Q22kHkPD4aGbKeHD09zesBXuXz+IFn3Icqtr36HCDFuF9j8Rk+a/4RSNbAYv?=
 =?us-ascii?Q?tVJXgFnrQFRkyz1xFr0+KnSyJiPHCIQETsFkODvmqQilGUXyuNfOtSml5jct?=
 =?us-ascii?Q?Hx2WTmRgYwCfaRZyYjG3SMeVX+otOJnByo2u+4xN5JwzoK6vbMXPK/55laZs?=
 =?us-ascii?Q?sS1EueuapMOd9YVn6J3/AXtBAJ4hTfMOf+U5Cl+IfiQoN2LPKJv3zMuOX7Qd?=
 =?us-ascii?Q?mqx7CA1epoEDWe4Y7jA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ef41f7-8a8b-4fd1-fcc9-08db46a04573
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 21:50:37.6471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yiW3loqUj5HagTPhGCEWI4xOEZ4MciBGOJf9k43b1jaAcfPK76UPPQb6NPViCInQRY2JcbQN7OPAC/jHyfZSYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

[Public]



> -----Original Message-----
> From: Anisse Astier <anisse@astier.eu>
> Sent: Wednesday, April 26, 2023 14:59
> To: linux-efi@vger.kernel.org
> Cc: Ard Biesheuvel <ardb@kernel.org>; Johan Hovold
> <johan+linaro@kernel.org>; Darren Hart <dvhart@infradead.org>; Andy
> Shevchenko <andy@infradead.org>; Thomas Gleixner <tglx@linutronix.de>;
> Ingo Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; Dave
> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H. Peter Anvin
> <hpa@zytor.com>; Jeremy Kerr <jk@ozlabs.org>; platform-driver-
> x86@vger.kernel.org; linux-kernel@vger.kernel.org; Anisse Astier
> <anisse@astier.eu>; Anisse Astier <an.astier@criteo.com>
> Subject: [PATCH] efivarfs: expose used and total size
>=20
> From: Anisse Astier <an.astier@criteo.com>
>=20
> When writing variables, one might get errors with no other message on
> why it fails.
>=20
> Being able to see how much is used by EFI variables helps analyzing such
> issues.
>=20
> Since this is not a conventionnal filesystem, block size is
> intentionnally set to 1 instead of PAGE_SIZE.
>=20
> x86 quirks of reserved size are taken into account and available and
> free size can be different, further helping debugging space issues.

+hughsie

This can be quite useful for fwupd to be capturing as well with some of the
weird issues that look like they're probably related to how much variable
space is left.

>=20
> Signed-off-by: Anisse Astier <an.astier@criteo.com>
> ---
> Notes:
> Patch isn't split per subsystem intentionally, for better understanding
> of intent; split could be trivial in a later version.
>=20
> I'm not sure whether statfs(2) should return an error if the efi request
> fails; I think it could be ignored with maybe a WARN_ONCE; which would
> be close to the current behaviour.
>=20
> Regards,
>=20
> Anisse
>=20
> ---
>  arch/x86/platform/efi/quirks.c |  8 ++++++++
>  drivers/firmware/efi/efi.c     |  1 +
>  drivers/firmware/efi/vars.c    | 12 ++++++++++++
>  fs/efivarfs/super.c            | 26 +++++++++++++++++++++++++-
>  include/linux/efi.h            | 10 ++++++++++
>  5 files changed, 56 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirk=
s.c
> index b0b848d6933a..587fa51230e2 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -114,6 +114,14 @@ void efi_delete_dummy_variable(void)
>  				     EFI_VARIABLE_RUNTIME_ACCESS, 0,
> NULL);
>  }
>=20
> +u64 efi_reserved_space(void)
> +{
> +	if (efi_no_storage_paranoia)
> +		return 0;
> +	return EFI_MIN_RESERVE;
> +}
> +EXPORT_SYMBOL_GPL(efi_reserved_space);
> +
>  /*
>   * In the nonblocking case we do not attempt to perform garbage
>   * collection if we do not have enough free space. Rather, we do the
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index abeff7dc0b58..d0dfa007bffc 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -211,6 +211,7 @@ static int generic_ops_register(void)
>  	generic_ops.get_variable =3D efi.get_variable;
>  	generic_ops.get_next_variable =3D efi.get_next_variable;
>  	generic_ops.query_variable_store =3D efi_query_variable_store;
> +	generic_ops.query_variable_info =3D efi.query_variable_info;
>=20
>  	if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
>  		generic_ops.set_variable =3D efi.set_variable;
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index bd75b87f5fc1..c5382d5c3073 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -245,3 +245,15 @@ efi_status_t efivar_set_variable(efi_char16_t
> *name, efi_guid_t *vendor,
>  	return status;
>  }
>  EXPORT_SYMBOL_NS_GPL(efivar_set_variable, EFIVAR);
> +
> +efi_status_t efivar_query_variable_info(u32 attr,
> +					u64 *storage_space,
> +					u64 *remaining_space,
> +					u64 *max_variable_size)
> +{
> +	if (!__efivars->ops->query_variable_info)
> +		return EFI_UNSUPPORTED;
> +	return __efivars->ops->query_variable_info(attr, storage_space,
> +			remaining_space, max_variable_size);
> +}
> +EXPORT_SYMBOL_NS_GPL(efivar_query_variable_info, EFIVAR);
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 482d612b716b..064bfc0243c9 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -13,6 +13,7 @@
>  #include <linux/ucs2_string.h>
>  #include <linux/slab.h>
>  #include <linux/magic.h>
> +#include <linux/statfs.h>
>=20
>  #include "internal.h"
>=20
> @@ -23,8 +24,31 @@ static void efivarfs_evict_inode(struct inode *inode)
>  	clear_inode(inode);
>  }
>=20
> +static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> +{
> +	u64 storage_space, remaining_space, max_variable_size;
> +	efi_status_t status;
> +	const u32 attr =3D (EFI_VARIABLE_NON_VOLATILE |
> EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +	 EFI_VARIABLE_RUNTIME_ACCESS);
> +
> +	buf->f_type =3D dentry->d_sb->s_magic;
> +	buf->f_bsize =3D 1;
> +	buf->f_namelen =3D NAME_MAX;
> +
> +	status =3D efivar_query_variable_info(attr, &storage_space,
> &remaining_space,
> +					    &max_variable_size);
> +	if (status !=3D EFI_SUCCESS)
> +		return efi_status_to_err(status);
> +	buf->f_blocks =3D storage_space;
> +	buf->f_bfree =3D remaining_space;
> +	if (remaining_space > efi_reserved_space())
> +		buf->f_bavail =3D remaining_space - efi_reserved_space();
> +	else
> +		buf->f_bavail =3D 0;
> +	return 0;
> +}
>  static const struct super_operations efivarfs_ops =3D {
> -	.statfs =3D simple_statfs,
> +	.statfs =3D efivarfs_statfs,
>  	.drop_inode =3D generic_delete_inode,
>  	.evict_inode =3D efivarfs_evict_inode,
>  };
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 7aa62c92185f..d2b686191870 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -703,6 +703,7 @@ static inline void efi_enter_virtual_mode (void) {}
>  extern efi_status_t efi_query_variable_store(u32 attributes,
>  					     unsigned long size,
>  					     bool nonblocking);
> +extern u64 efi_reserved_space(void);
>  #else
>=20
>  static inline efi_status_t efi_query_variable_store(u32 attributes,
> @@ -711,6 +712,10 @@ static inline efi_status_t
> efi_query_variable_store(u32 attributes,
>  {
>  	return EFI_SUCCESS;
>  }
> +static inline u64 efi_reserved_space(void)
> +{
> +	return 0;
> +}
>  #endif
>  extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
>=20
> @@ -1042,6 +1047,7 @@ struct efivar_operations {
>  	efi_set_variable_t *set_variable;
>  	efi_set_variable_t *set_variable_nonblocking;
>  	efi_query_variable_store_t *query_variable_store;
> +	efi_query_variable_info_t *query_variable_info;
>  };
>=20
>  struct efivars {
> @@ -1087,6 +1093,10 @@ efi_status_t
> efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
>  efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
>  				 u32 attr, unsigned long data_size, void
> *data);
>=20
> +efi_status_t efivar_query_variable_info(u32 attr, u64 *storage_space,
> +					u64 *remaining_space,
> +					u64 *max_variable_size);
> +
>  #if IS_ENABLED(CONFIG_EFI_CAPSULE_LOADER)
>  extern bool efi_capsule_pending(int *reset_type);
>=20
> --
> 2.34.1
