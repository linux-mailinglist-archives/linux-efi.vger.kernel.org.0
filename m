Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E3512835A
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2019 21:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLTUn6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Dec 2019 15:43:58 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40703 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfLTUn6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Dec 2019 15:43:58 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so10690162iop.7
        for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2019 12:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jqg7RZc+nwEpmF5q79/89N5Znjo+0UdOCx5aFdL9MFw=;
        b=sq77s/RCYJNhgQjLDu46jcHEHrCxvNDBqkmD4zwBcDADMSS5Hm4cyTDDQ9I8BW0tHX
         mZWGe3zhhV8VXeSaUAcbUlpC+zo2hif20QkyV0d/IIlwTaOj+bR5YiqXCU+Bpbl28QHb
         3qZjQzivRalAtwbLzPmBX44e2MQbTt0ivF0LMGWgczl0n8Mdqq04H0kdYO5FkZFcZ11N
         DTgoaBPT8LSxEavQIHkCzJbdtQLV6mLoYezYFJmadVmFUbrpr7HokKyO75r9kbRzWFIn
         N/6uSZRSguxEkkOEDr8sgP5LBwBmOgnggdHAQDJAFS9TsqFrca2okzR2roOVaEYmH/5/
         F4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jqg7RZc+nwEpmF5q79/89N5Znjo+0UdOCx5aFdL9MFw=;
        b=B5CG5Ut+eXslKbtnyK6OEXaCfjIwxULVkZ5M+7Y/FUivMttzKsbiBlSgBtWbEThDFX
         //KEGkjiPY894XxbyplgwrMJKa6CKshLLiyxwgAe03zNVBKVkPzxFwAZGoUqcjlx53ao
         gIiRZ9RtLmd2ha+Ax2cCLv1njsem5EXgkJAXsqmEPt3zCkjjpDLyeyomELk78jKI5GBf
         0i4xlMzMHMx58RGSHJ2jENAQhJTdu1WX9LnquG/FGNMlOsLA/wzZCw35gIXJHg3JRwkQ
         6pZuwz5DpvRUbi//bdNotNOeBzHySlFLQs/rRpxtV+c5ZT+QURsCfFpb4risZINa01yu
         kMHA==
X-Gm-Message-State: APjAAAWS4Uy7UTo75ztMAWpHxF5vm898HsvilFEhXPOQ/1/KtZU3hQJK
        OQItGjuTlI8U7/1NWa4vt7XU1NCRuhKPhSF5LC3vEg==
X-Google-Smtp-Source: APXvYqzGhgW87XKcmZeg/acYlU5APOQQ79/DF85E6xH5xnHb1ToSlEQLvS3OzBLq6syfSNGenEUvON4/JcIL7BpPo18=
X-Received: by 2002:a05:6602:187:: with SMTP id m7mr11753340ioo.16.1576874636003;
 Fri, 20 Dec 2019 12:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-22-ardb@kernel.org>
 <CACdnJusxs_vAMvE_tOX12ZJiEc3__1NimT3aD3r-Oabvx62FtA@mail.gmail.com> <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 20 Dec 2019 12:43:44 -0800
Message-ID: <CACdnJuucz5CC=LVA5589t0SByH6NHfxbjqm1ONv1nArnUEaHoA@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 19, 2019 at 11:07 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 19 Dec 2019 at 22:05, Matthew Garrett <mjg59@google.com> wrote:
> >
> > On Wed, Dec 18, 2019 at 9:03 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > +       status = efi_call_early(create_event, EVT_SIGNAL_EXIT_BOOT_SERVICES,
> > > +                               TPL_CALLBACK, handle_exit_boot_services_event,
> > > +                               NULL, &exit_boot_services_event);
> > > +       if (status != EFI_SUCCESS) {
> > > +               pr_efi_err("Failed to register for EBS() event\n");
> > > +               goto free_handle;
> > > +       }
> >
> > OVMF's SEV implementation appears to tear down AMD's IOMMU mappings at
> > EVT_SIGNAL_EXIT_BOOT_SERVICES. How are we ensuring that this happens
> > first?
>
> It doesn't, and that is kind of the point. The only guarantee you have
> is that this runs before ExitBootServices() returns, but after any
> other callbacks that have been registered. I know this is not 100%
> what you're after, but it is the only way we can avoid poking devices
> behind the backs of their drivers.

Hm. In that case, I think this version fails to match the patch
description - there's potentially still a window where DMA-capable PCI
devices can attack the kernel, it's just smaller. If disconnecting
drivers from the device would give us the same expectations then that
seems like a better approach, but I think I probably wouldn't add my
signed-off-by to this version.
