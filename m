Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBE626870B
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 10:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgINISj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 04:18:39 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:27593 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgINIGJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Sep 2020 04:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1600070746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9zrq81Mo28+NQyDUlvCaJnp+1yIygyJXk13e+8ZEXX0=;
        b=W1K4kloQUhm2SQ8Y2oTxtMzwz87QT6WogAFpVQkdfEjJoNvdLkBTJLLCgZtyM+X/Vs9lid
        YyVsLCxgftPwZw+Ig4TiU/GSnN/DcgLiE8OiNednzZHGJnpEGZUlLlp6SZ9SVxsVvQg9aK
        FxU4h4xMVrEX3Y3YP6ITX+JWaw5qI1g=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-14-dg1kK9xGNMK_nL_GXrpcww-1; Mon, 14 Sep 2020 10:05:44 +0200
X-MC-Unique: dg1kK9xGNMK_nL_GXrpcww-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nba2YkkU3lPoUFct6CVYbIUNdm6eM+NkJP8ZNLBtQFIr9J803rHUiyFwTzb4EoCZvMO1L+gN6NX744Z2ldXDy5RNOe+SM60xP+xnhnQMysCxTfojMnOaTCcNXFoP+y+q0dSU/F0nTLl10UExpDc597se3q1eDb4XCsRMWS07/yinIRGwq51qNZlRiEm42Nw2Haz8tkIQXswUdbnrJ92n12t2/EUeZ7WepsCHgamLLiFKYnk5KGW79SO9dH5QrkOq9LYBeDiIfHp51fMcckPrrcaxjL0UGNUQrgwUTY659NeE4UHbDYOC/TPWysyJDGdC0k7YCvGDbpw1GKowDcrAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zrq81Mo28+NQyDUlvCaJnp+1yIygyJXk13e+8ZEXX0=;
 b=f4FeRWaGFeLKK7cSkNA8/Ck/U0eIB7xqK8+1PBsu1kUClKCudX1/zgyPTTa60u/DFfRkKMG3uz1EDjD4f1o6GJ05aKWCSYXtWw/K0jtkCQorEG05VfjdAAArZrs301N0sC67QAdimAvZFSJPd2o7cC4MoNCXK9K/f21sXnSNIoauBLjGdpZR1GhV9DlJC7zPOjvHx5+ZSJm9RNhuCoyJXd9VucbtcW1h5qPNH+0baO64TUKGyGIDx73YScZNNCAFH1Xpwbes8V1cMpFjgpVI4HYxaHqgh8bsUZ2TsYc2YW4+xWXLdWghHDf1tgtJJQOHAafXxobe1vTCKIy0BCNG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR04MB4927.eurprd04.prod.outlook.com (2603:10a6:803:59::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 08:05:42 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::ecc4:8ee7:3117:7b43]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::ecc4:8ee7:3117:7b43%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 08:05:42 +0000
Date:   Mon, 14 Sep 2020 16:05:22 +0800
From:   Chester Lin <clin@suse.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>, clin@suse.com
Subject: Re: [PATCH 1/6] efistub: pass uefi secureboot flag via fdt params
Message-ID: <20200914080522.GA26718@linux-8mug>
References: <20200904072905.25332-1-clin@suse.com>
 <20200904072905.25332-2-clin@suse.com>
 <CAMj1kXEXvmO5mrTcKpqYUASBAQB-1=xLa0vg7KwmvOHMjaQ34w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEXvmO5mrTcKpqYUASBAQB-1=xLa0vg7KwmvOHMjaQ34w@mail.gmail.com>
X-ClientProxiedBy: HK0PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::17) To VI1PR04MB4928.eurprd04.prod.outlook.com
 (2603:10a6:803:57::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (114.24.11.93) by HK0PR01CA0053.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 08:05:35 +0000
X-Originating-IP: [114.24.11.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b11a6c5d-d912-4d75-e432-08d85884f979
X-MS-TrafficTypeDiagnostic: VI1PR04MB4927:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4927882EFDFF39AD8F558ECBAD230@VI1PR04MB4927.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gzSJO2R4xJ4Ov4ERPFM1euuP0QqxOtBR0zjELyIs0ab8OIKRqOmZ6cYyKYn6Jaj/nUGRGRO/iJMU7iZEfKjkQ3yXJgfxcofZ/k0sKADnyrQrjJExeNX0j6hwYg2Omm/oQ/RY2EMxTo+LX+ZB15cgehrM3Bje46JDRplDCrM/pSab8wqYelkYovdj3hyZxRVfz79up57Y+oyVq8lZIeimvJDLK0iDJSae5ydJHQRnUDSriDmPSS6fqtbVpDKEK1JgLyHo5TA2IdwAZ0Ue27Mbre9AyBr5Ij599bTQIOQFslvJDxzlDhlc5zopUkuNDtX1q3ZRH2zr4KLAlWrtJKWUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(396003)(366004)(376002)(186003)(1076003)(107886003)(16526019)(66556008)(55016002)(66476007)(2906002)(4326008)(66946007)(478600001)(316002)(6496006)(7416002)(956004)(52116002)(9686003)(8936002)(83380400001)(8676002)(26005)(6666004)(54906003)(33656002)(86362001)(5660300002)(6916009)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pE5tIhbVt+geHZhIJQWp9KG34+3YL4+PpK/FA7g/XOJARbhBuEv4T3ingosZU5Hcr9f1Fc1AvckJi7X1DMJ92L43L/JePfDGnjtfyteIWSuEEvIdenDwb2OI9g3Uqatx2U54A0MasWTG7+f7gXlnPMSt1p+e7264muGt9jQjT17+OhBGJONQGVuE07gGeGYt73OqdI+Y7547ujeJgUIkhoUgWmECS5SSLDNOoDUOjs0y+clCSdQBbN1iKVCZdl4d8WFwH/crDuN0x19FXu18Sj0GiLn1J5y6WmdKPwQfRbKinfXzndkFfnoANuwsGk56mNYRXnrsEE/AjanGxC+sXiTPsIBNix2q7LeHt1rCscDnjRspSbF19tydxqK2VWghUdY3cVboXgfNdQOkF8SW26j643E9O1sN/FkI4ESad4pEIkZAz/8Aaeznj6MHmQJGJ2vwVMuOZreqjol+0/zsEJAFLv8566QVA36QOTsFdCv1OVO+uQhD6k2JeeLpxCqsLsfPhSg58dbGlFIPB5DW9J4xDWJTCMdjVuXSTvogvs3xcthA6kjTEiXdBCM8jAS3Sn0yQQjbLWnzkNrYPc4Qk6oxxbRYf20HEWqz5fD4ppIkMTr3WROLR22Xm0kr27uT613+jxXlsJp+zGdFn2RxLg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11a6c5d-d912-4d75-e432-08d85884f979
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 08:05:42.2614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQsG7h38r9anG6teRHPrq6Foz14vWY05Gb7uF28jiUjayK/VtH2yVpGFKBUakBk5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4927
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Fri, Sep 11, 2020 at 06:01:09PM +0300, Ard Biesheuvel wrote:
> On Fri, 4 Sep 2020 at 10:29, Chester Lin <clin@suse.com> wrote:
> >
> > Add a new UEFI parameter: "linux,uefi-secure-boot" in fdt boot params
> > as other architectures have done in their own boot data. For example,
> > the boot_params->secure_boot in x86.
> >
> > Signed-off-by: Chester Lin <clin@suse.com>
> 
> Why do we need this flag? Can't the OS simply check the variable directly?
> 

In fact, there's a difficulty to achieve this.

When linux kernel is booting on ARM, the runtime services are enabled later on.
It's done by arm_enable_runtime_services(), which is registered as an early_initcall.
Before it calls efi_native_runtime_setup(), all EFI runtime callbacks are still
NULL so calling efi.get_variable() will cause NULL pointer dereference.

There's a case that arch_ima_get_secureboot() can be called in early boot stage.
For example, when you try to set "ima_appraise=off" in kernel command line, it's
actually handled early:

[    0.000000] Kernel command line: BOOT_IMAGE=/boot/Image-5.9.0-rc3-9.gdd61cda-
vanilla root=UUID=a88bfb80-8abb-425c-a0f3-ad317465c28b splash=silent mitigations
=auto ignore_loglevel earlycon=pl011,mmio,0x9000000 console=ttyAMA0 ima_appraise=off
[    0.000000] ima: Secure boot enabled: ignoring ima_appraise=off boot parameter option
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)

However EFI services are remapped and enabled afterwards.

[    0.082286] rcu: Hierarchical SRCU implementation.
[    0.089592] Remapping and enabling EFI services.
[    0.097509] smp: Bringing up secondary CPUs ...

Another problem is that efi_rts_wq is created in subsys_initcall so we have to
wait for both EFI services mapping and the workqueue get initiated before calling
efi.get_variable() on ARM.

The only way I can think of is to put a flag via fdt params. May I have your
suggestions? I will appreciate if there's any better approach.

Thanks,
Chester

> > ---
> >  drivers/firmware/efi/libstub/fdt.c | 39 +++++++++++++++++++++++++++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> > index 11ecf3c4640e..c9a341e4715f 100644
> > --- a/drivers/firmware/efi/libstub/fdt.c
> > +++ b/drivers/firmware/efi/libstub/fdt.c
> > @@ -136,6 +136,10 @@ static efi_status_t update_fdt(void *orig_fdt, unsigned long orig_fdt_size,
> >         if (status)
> >                 goto fdt_set_fail;
> >
> > +       status = fdt_setprop_var(fdt, node, "linux,uefi-secure-boot", fdt_val32);
> > +       if (status)
> > +               goto fdt_set_fail;
> > +
> >         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> >                 efi_status_t efi_status;
> >
> > @@ -199,6 +203,24 @@ static efi_status_t update_fdt_memmap(void *fdt, struct efi_boot_memmap *map)
> >         return EFI_SUCCESS;
> >  }
> >
> > +static efi_status_t update_fdt_secboot(void *fdt, u32 secboot)
> > +{
> > +       int node = fdt_path_offset(fdt, "/chosen");
> > +       u32 fdt_val32;
> > +       int err;
> > +
> > +       if (node < 0)
> > +               return EFI_LOAD_ERROR;
> > +
> > +       fdt_val32 = cpu_to_fdt32(secboot);
> > +
> > +       err = fdt_setprop_inplace_var(fdt, node, "linux,uefi-secure-boot", fdt_val32);
> > +       if (err)
> > +               return EFI_LOAD_ERROR;
> > +
> > +       return EFI_SUCCESS;
> > +}
> > +
> >  struct exit_boot_struct {
> >         efi_memory_desc_t       *runtime_map;
> >         int                     *runtime_entry_count;
> > @@ -208,6 +230,9 @@ struct exit_boot_struct {
> >  static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
> >                                    void *priv)
> >  {
> > +       efi_status_t status;
> > +       enum efi_secureboot_mode secboot_status;
> > +       u32 secboot_var = 0;
> >         struct exit_boot_struct *p = priv;
> >         /*
> >          * Update the memory map with virtual addresses. The function will also
> > @@ -217,7 +242,19 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
> >         efi_get_virtmap(*map->map, *map->map_size, *map->desc_size,
> >                         p->runtime_map, p->runtime_entry_count);
> >
> > -       return update_fdt_memmap(p->new_fdt_addr, map);
> > +       status = update_fdt_memmap(p->new_fdt_addr, map);
> > +
> > +       if (status != EFI_SUCCESS)
> > +               return status;
> > +
> > +       secboot_status = efi_get_secureboot();
> > +
> > +       if (secboot_status == efi_secureboot_mode_enabled)
> > +               secboot_var = 1;
> > +
> > +       status = update_fdt_secboot(p->new_fdt_addr, secboot_var);
> > +
> > +       return status;
> >  }
> >
> >  #ifndef MAX_FDT_SIZE
> > --
> > 2.26.1
> >
> 

