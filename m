Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC72585C9D
	for <lists+linux-efi@lfdr.de>; Thu,  8 Aug 2019 10:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbfHHIRJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Aug 2019 04:17:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41442 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731642AbfHHIRI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Aug 2019 04:17:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so90742079wrm.8
        for <linux-efi@vger.kernel.org>; Thu, 08 Aug 2019 01:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38ju4Gl4Grvf533Kz32OKqL5q5T3Vt8AuXew6FwiqWw=;
        b=rUCQUYUxtfEuD8UrKfSYCrf7QT2/AK44Wv0N87w/ZViL9ThDxkKLyk9W96EPTSZnH+
         d/40POXp+QGbaV3Oa0gMKkjAN+wWUZLB/bZcOftPUPp6fQNSj/tLK13kFNxU2c22QB22
         6wO6grLd/Me1wdnmZJkzcWaZzsg4bdtVNheNDhsi8YC0VlxA4mwAH9dPQBUbYOQVYYvK
         A9GCvcRUkibF0gwnjA6haXFRH3Gj7dv3W4r31wGZansDQsSlfSfM+Fh3hL5rpR4gPuFT
         DIPTJeb1OHX3hZ8cqTYr/kigu0h4sZjuI7JtYbQZjQQI6XAP7XyphYAfZ00r4yRzB4on
         RUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38ju4Gl4Grvf533Kz32OKqL5q5T3Vt8AuXew6FwiqWw=;
        b=A338dhd+FX+4XpKS2f0+9DrQ7M/b9NkKS+fDUTWl+q3Y0lhkP4tfbktZAJieqqjUly
         6jRcJoyNko5shkh/2QeiFFN1+4bomxx9fpdprebe1AxMoVZs4X8TY3TQ0Cfzl/GSYg5J
         +2bk8hfBRl8qz7VM6I3QagI4UjEl5ZGF6m6V03CSs8D03U7Zr5nGAPMeDQssFN4IQ0Fh
         v7+xSQwx5W+xYw9BzyXNHTluLcuslWtvxmTpdblH9CRUwvKI9SYv26yPjDXqboJnXo3t
         PiPKiXwCtGSVGpyUrrQOWKBdDwleyytjM05aOywN18vsHCoUAiRN4UZLr7SKaBlry7W+
         K/aw==
X-Gm-Message-State: APjAAAXkgywK17jITF5gvzb9opHdHut/6C3tesvXX/LwxGhVw6rBQkGD
        KLRujTdKHD2vC1PiWgohfkMcXiyNJ2375fn/TQUjPQ==
X-Google-Smtp-Source: APXvYqywnrTIIufTFkkEGfDV2mri5pljOv015D6gGy76sUh+KFPu74K+P8t6zpFPuYqvh7aI5ZaRpUvuazh5+ayxwQ0=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr15990808wrs.93.1565252226737;
 Thu, 08 Aug 2019 01:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190710185853.GA2645@localhost.localdomain> <3b26bccb3caa4360a552f1dc57b9ac24@AUSX13MPC105.AMER.DELL.COM>
 <20190807130840.GA2147@localhost.localdomain>
In-Reply-To: <20190807130840.GA2147@localhost.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 8 Aug 2019 11:16:55 +0300
Message-ID: <CAKv+Gu8-BTwpFz0dyNDoAP9xhrDQH4Qm0m73uAi2T0ckVrR5tw@mail.gmail.com>
Subject: Re: [PATCH v1] Export Runtime Configuration Interface table to sysfs
To:     Narendra.K@dell.com
Cc:     Mario.Limonciello@dell.com, linux-efi <linux-efi@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>, Stuart.Hayes@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 7 Aug 2019 at 16:09, <Narendra.K@dell.com> wrote:
>
> On Thu, Jul 11, 2019 at 11:00:37PM +0000, Limonciello, Mario wrote:
> > > -----Original Message-----
> > > From: K, Narendra
> > > Sent: Wednesday, July 10, 2019 11:59 AM
> > > To: linux-efi@vger.kernel.org; ard.biesheuvel@linaro.org; pjones@redhat.com
> > > Cc: K, Narendra; Hayes, Stuart; Limonciello, Mario
> > > Subject: [PATCH v1] Export Runtime Configuration Interface table to sysfs
> > >
> > > From: Narendra K <Narendra.K@dell.com>
> > >
> > > System firmware advertises the address of the 'Runtime Configuration Interface
> > > table version 2 (RCI2)' via an EFI Configuration Table entry. This code retrieves
> > > the RCI2 table from the address and exports it to sysfs as a binary attribute 'rci2'
> > > under /sys/firmware/efi/tables directory.
> > > The approach adopted is similar to the attribute 'DMI' under
> > > /sys/firmware/dmi/tables.
> > >
> > > RCI2 table contains BIOS HII in XML format and is used to populate BIOS setup
> > > page in Dell EMC OpenManage Server Administrator tool.
> > > The BIOS setup page contains BIOS tokens which can be configured.
> > >
> > > Signed-off-by: Narendra K <Narendra.K@dell.com>
> >
> > Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
>
> Hi Ard,
>
> Does the version 1 of the patch look good ? Please share your thoughts.
>

Thanks Narendra,

The patch looks mostly fine. I have pushed it to my efi/next branch,
and I will let you know if the autobuilders find any problems.

One possible enhancement would be to defer the second memremap() call
until the first call to raw_table_read(), so the mapping only exists
if you are actually interested in the contents of the table. If you do
decide to make any followup changes, please send them as delta patches
against https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next

Thanks,
Ard.




> >
> > > ---
> > > Hi Ard, the review comment in the v0 version of the patch suggested that the
> > > kconfig symbol be set to Y for X86. I made a change to the suggestion.
> > > In the v1 version, I have set the symbol to N by default and added a note to the
> > > help section to make it Y for Dell EMC PowerEdge systems. If it needs to be
> > > changed, I will resubmit the patch after changing it to implement the suggestion.
> > >
> > > The patch is created on 'next' branch of efi tree.
> > >
> > > v0 -> v1:
> > > - Introduced a new Kconfig symbol CONFIG_EFI_RCI2_TABLE and compile
> > > RCI2 table support if it is set. Set the symbol to N by default.
> > > - Removed calling 'efi_rci2_sysfs_init' from drivers/firmware/efi/efi.c and made
> > > it a 'late_initcall' in drivers/firmware/efi/rci2_table.c.
> > > Removed the function declaration from include/linux/efi.h.
> > >
> > > RFC -> v0:
> > > - Removed rci2 table from struct efi and defined it in rci2_table.c similar to the
> > > way uv_systab_phys is defined in arch/x86/platform/uv/bios_uv.c
> > > - Removed the oem_tables array and added rci2 to common_tables array
> > > - Removed the string 'rci2' from the common_tables array so that it is not
> > > printed in dmesg.
> > > - Merged function 'efi_rci2_table_init' into 'efi_rci2_sysfs_init' function to avoid
> > > calling early_memremap/unmap functions.
>
> --
> With regards,
> Narendra K
