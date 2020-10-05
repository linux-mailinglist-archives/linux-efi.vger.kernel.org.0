Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDBB282EC9
	for <lists+linux-efi@lfdr.de>; Mon,  5 Oct 2020 04:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgJEC1I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 4 Oct 2020 22:27:08 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:41828 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbgJEC1I (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 4 Oct 2020 22:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1601864823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4xHR2HS7nW0UYmT5nX+2J9YrUCch3fVgPCRKjZBNvpo=;
        b=IEOmWtJau/rixyhIT7SLIPHhBH9qw+/sy0V94s8zLh8DSXr3eF7kW9Q7HW/3xA9grO6do+
        nrX1/nxDm33g6w7LJfeXnWOjobWyjDBz0xlSpBtuoAMTjr19Dcdqqvf7NB/slMRvjvTXzR
        FihcgHprBTO5oX2vVw7KjVHY/COKCj8=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2051.outbound.protection.outlook.com [104.47.10.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-35-FVpnR7V0N_qGwqm3mY-9ew-1; Mon, 05 Oct 2020 04:20:36 +0200
X-MC-Unique: FVpnR7V0N_qGwqm3mY-9ew-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkORIC68jeX7qNZ6wdfoqohgVvhAH3gvm3IHAe4aHBAuerGPeXGY8M/tmbxbl5NRfRGNDFyqhO1w5bvDfhToV/6VvAm9pI4e2rPiJmpBVPPr1BbNNGGV1/VipAp5NezSzO80TaK20TmgFfeQG7js4YNWZ/rAHyVJcCACMwfLuRMbEAAsQXsDYxJ3jopvzQdGn+Pjmlx1Xy/vCaS6FMRAoeI57vt+qfVmNTVwV3LyI0dg4sx0mykHpbYg5uOUrhc2DIT3vVEoNkUETYh/yIIux2Z7AZWlXyT11J80/P6HMFY2NeAPpTOlDMjJP2AaG6q/D+p7xgbMmVJnKVl8FjDDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xHR2HS7nW0UYmT5nX+2J9YrUCch3fVgPCRKjZBNvpo=;
 b=Z0mRxtJVcANkaznyCQyYeJeG+NXuXSPdsyxtp2fC1oCtifmU41yP6qvW9VbvNBgZXWm3DSDXtH8h6C7S5wzimMYuN2b5hwm3cW7hBZPbt+kfQ9/rOE08Rq8lxHYlP7Xr6HzUJYJQEfPssRDDWXAwcPWv9dwnQ12tx7CyHAVcIhLCy78yK4aRrOTuuZEFb50/US+lCb5HV27jP4Swgxq21R+HCfVbVcEK5aY/rB7VWceznqrWzO8ZSy/7Bz2nOfdPJ0YVCmD/SfUn+UUhx8YQtAxd/r+PUhUw/UXKBjTraqGgI+3ulCmr+oqdc8sMNxcXdGy3HSro+ZgQk+l5tKXeog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB4919.eurprd04.prod.outlook.com (2603:10a6:20b:c::23)
 by AM6PR04MB6166.eurprd04.prod.outlook.com (2603:10a6:20b:b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Mon, 5 Oct
 2020 02:20:34 +0000
Received: from AM6PR04MB4919.eurprd04.prod.outlook.com
 ([fe80::6418:c465:b47f:96c6]) by AM6PR04MB4919.eurprd04.prod.outlook.com
 ([fe80::6418:c465:b47f:96c6%4]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 02:20:34 +0000
Date:   Mon, 5 Oct 2020 10:20:14 +0800
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
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH 1/6] efistub: pass uefi secureboot flag via fdt params
Message-ID: <20201005022014.GA5112@linux-8mug>
References: <20200904072905.25332-1-clin@suse.com>
 <20200904072905.25332-2-clin@suse.com>
 <CAMj1kXEXvmO5mrTcKpqYUASBAQB-1=xLa0vg7KwmvOHMjaQ34w@mail.gmail.com>
 <20200914080522.GA26718@linux-8mug>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914080522.GA26718@linux-8mug>
X-Originating-IP: [114.24.11.63]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To AM6PR04MB4919.eurprd04.prod.outlook.com
 (2603:10a6:20b:c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (114.24.11.63) by HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.15 via Frontend Transport; Mon, 5 Oct 2020 02:20:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b0fc099-18ef-4d46-0184-08d868d53d48
X-MS-TrafficTypeDiagnostic: AM6PR04MB6166:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB6166C901789BA8143BC07157AD0C0@AM6PR04MB6166.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEkdn77Z4WqfzCeeXWQk3TAC91bkwDeuMRL6WYkqOALEpPC/TrLH/4f0N+j5fmyK3ULbUR9EZEQWQGl4S3B2x67pcnRAEqOMUH3ZmLHKFrqJaSb3tFWQmYpItpHuTr8YjIjFElTDuge4Z+EGPqVWz2cJFxemtRyd/nER/DiLJRGSh3BahTArvLqZtUwCYOXKIOo+OB616AnehhaDbPouIjh7E8bBMamsVoZTiVs5RrLxREoHzLmGsyfIuAN/rbtD/hcYJlHbm2E4m4A8oGv7caXksryhwZ+894ewWvhkd4ng/QvIOOblWChNb5WG/VBouWnXs/FXRL3hFSTS9e72ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4919.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(39860400002)(396003)(346002)(54906003)(107886003)(33656002)(33716001)(83380400001)(5660300002)(186003)(478600001)(16526019)(316002)(55016002)(52116002)(1076003)(4326008)(9686003)(6496006)(956004)(6916009)(86362001)(7416002)(8936002)(2906002)(8676002)(66476007)(66946007)(66556008)(26005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PUngHEfPwh1LB9LMlYBYock+PXpzTfuNg2+ZZRaBT04e6j0oK49YDIyFCRBkUGk8LjfWMn3zwrJvvNhs1KCmtnfhIABqyn6zFDeOiocw/M8a0oohGzqoTu0LS5IhQvqCG5/UdVSC9PyGd3u1WQtldQtRrmHJze03mDX135PoVhA3RgdMlF3e8GohAQsxB80MUE1HwNA+x5V638XrqUBjXKb7zIZkRxX60ZOy/3wuGR6WW4LYtJ5StvRnRM+1RVXxtLN1z7xEWRzMK1PNzBRRxNbMgfXVCdTEQM7mZSR962V8oa7d/3RZXSFKEoqIUlserigMsYGu2xWC4n7ZhGT230CZMZ7abHgDW5Q3124ZLj7Z54Acf3JbRdhefI0S9Bm9A0YvyGJLzDU/6zPx89M0MpJq05IvsYSjs7zm1TdQ10O10OYNxchEiPMBhGWZb17ic1CfLrBLcldOitXxkLJlnX6IuUM9Uv44b5MloZUaidJt8Nwj2I9R7HvX+zTCcOEvyCoeIaqerQ2a5C3K7PVOeaUoE753gXGZ7cT2xQJ5Y/SMMBdD3rGUwax46ajdWM8WXVa7Ce1gOPO9/rJTDLS6LgguQsOKz0Fohu2CZNWd7B5Xt1A9OUnwRZJB0mgmmXGYXSJbZaAmw0ZLMk9FBEkaYA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0fc099-18ef-4d46-0184-08d868d53d48
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4919.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 02:20:34.2095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xf87m7glF5JlnEaLrX6eZCro2G/PGFcmpRczOvx9DtFBAA8GygcnuwrZCVeIwemL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6166
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 14, 2020 at 04:05:22PM +0800, Chester Lin wrote:
> Hi Ard,
> 
> On Fri, Sep 11, 2020 at 06:01:09PM +0300, Ard Biesheuvel wrote:
> > On Fri, 4 Sep 2020 at 10:29, Chester Lin <clin@suse.com> wrote:
> > >
> > > Add a new UEFI parameter: "linux,uefi-secure-boot" in fdt boot params
> > > as other architectures have done in their own boot data. For example,
> > > the boot_params->secure_boot in x86.
> > >
> > > Signed-off-by: Chester Lin <clin@suse.com>
> > 
> > Why do we need this flag? Can't the OS simply check the variable directly?
> > 
> 
> In fact, there's a difficulty to achieve this.
> 
> When linux kernel is booting on ARM, the runtime services are enabled later on.
> It's done by arm_enable_runtime_services(), which is registered as an early_initcall.
> Before it calls efi_native_runtime_setup(), all EFI runtime callbacks are still
> NULL so calling efi.get_variable() will cause NULL pointer dereference.
> 
> There's a case that arch_ima_get_secureboot() can be called in early boot stage.
> For example, when you try to set "ima_appraise=off" in kernel command line, it's
> actually handled early:
> 
> [    0.000000] Kernel command line: BOOT_IMAGE=/boot/Image-5.9.0-rc3-9.gdd61cda-
> vanilla root=UUID=a88bfb80-8abb-425c-a0f3-ad317465c28b splash=silent mitigations
> =auto ignore_loglevel earlycon=pl011,mmio,0x9000000 console=ttyAMA0 ima_appraise=off
> [    0.000000] ima: Secure boot enabled: ignoring ima_appraise=off boot parameter option
> [    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> 
> However EFI services are remapped and enabled afterwards.
> 
> [    0.082286] rcu: Hierarchical SRCU implementation.
> [    0.089592] Remapping and enabling EFI services.
> [    0.097509] smp: Bringing up secondary CPUs ...
> 
> Another problem is that efi_rts_wq is created in subsys_initcall so we have to
> wait for both EFI services mapping and the workqueue get initiated before calling
> efi.get_variable() on ARM.
> 
> The only way I can think of is to put a flag via fdt params. May I have your
> suggestions? I will appreciate if there's any better approach.
> 
> Thanks,
> Chester

Ping. May I have some suggestions here?

Thanks,
Chester

> 
> > > ---
> > >  drivers/firmware/efi/libstub/fdt.c | 39 +++++++++++++++++++++++++++++-
> > >  1 file changed, 38 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> > > index 11ecf3c4640e..c9a341e4715f 100644
> > > --- a/drivers/firmware/efi/libstub/fdt.c
> > > +++ b/drivers/firmware/efi/libstub/fdt.c
> > > @@ -136,6 +136,10 @@ static efi_status_t update_fdt(void *orig_fdt, unsigned long orig_fdt_size,
> > >         if (status)
> > >                 goto fdt_set_fail;
> > >
> > > +       status = fdt_setprop_var(fdt, node, "linux,uefi-secure-boot", fdt_val32);
> > > +       if (status)
> > > +               goto fdt_set_fail;
> > > +
> > >         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> > >                 efi_status_t efi_status;
> > >
> > > @@ -199,6 +203,24 @@ static efi_status_t update_fdt_memmap(void *fdt, struct efi_boot_memmap *map)
> > >         return EFI_SUCCESS;
> > >  }
> > >
> > > +static efi_status_t update_fdt_secboot(void *fdt, u32 secboot)
> > > +{
> > > +       int node = fdt_path_offset(fdt, "/chosen");
> > > +       u32 fdt_val32;
> > > +       int err;
> > > +
> > > +       if (node < 0)
> > > +               return EFI_LOAD_ERROR;
> > > +
> > > +       fdt_val32 = cpu_to_fdt32(secboot);
> > > +
> > > +       err = fdt_setprop_inplace_var(fdt, node, "linux,uefi-secure-boot", fdt_val32);
> > > +       if (err)
> > > +               return EFI_LOAD_ERROR;
> > > +
> > > +       return EFI_SUCCESS;
> > > +}
> > > +
> > >  struct exit_boot_struct {
> > >         efi_memory_desc_t       *runtime_map;
> > >         int                     *runtime_entry_count;
> > > @@ -208,6 +230,9 @@ struct exit_boot_struct {
> > >  static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
> > >                                    void *priv)
> > >  {
> > > +       efi_status_t status;
> > > +       enum efi_secureboot_mode secboot_status;
> > > +       u32 secboot_var = 0;
> > >         struct exit_boot_struct *p = priv;
> > >         /*
> > >          * Update the memory map with virtual addresses. The function will also
> > > @@ -217,7 +242,19 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
> > >         efi_get_virtmap(*map->map, *map->map_size, *map->desc_size,
> > >                         p->runtime_map, p->runtime_entry_count);
> > >
> > > -       return update_fdt_memmap(p->new_fdt_addr, map);
> > > +       status = update_fdt_memmap(p->new_fdt_addr, map);
> > > +
> > > +       if (status != EFI_SUCCESS)
> > > +               return status;
> > > +
> > > +       secboot_status = efi_get_secureboot();
> > > +
> > > +       if (secboot_status == efi_secureboot_mode_enabled)
> > > +               secboot_var = 1;
> > > +
> > > +       status = update_fdt_secboot(p->new_fdt_addr, secboot_var);
> > > +
> > > +       return status;
> > >  }
> > >
> > >  #ifndef MAX_FDT_SIZE
> > > --
> > > 2.26.1
> > >
> > 

