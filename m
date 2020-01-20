Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3288143469
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jan 2020 00:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgATXSS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Jan 2020 18:18:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33351 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgATXSS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Jan 2020 18:18:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id d139so896056wmd.0
        for <linux-efi@vger.kernel.org>; Mon, 20 Jan 2020 15:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2YTMxBWhx7Otjnn8r5v7NzSq3gAYo+K8MrbMb1Wf8a4=;
        b=keGeVmaua312ZZ03Dym3shj0xcDQDYg1grRvVYsLFkBUQnZoKznSlOHun4+yttx20L
         GbVr1dyzmkAwZtYz+m+nd/iHpOJI3N8A5NwkH+vEp8G596bOXYpFT7MuvtjRGO8SzA/j
         HkHp7J5m6g4UwYhXJtNpVHkbrgJQLFRj8guJwWnfiMsWENdaV/Lr3wXSZOqv47pnF2qI
         DDGRm1TSOaWBcxqLctUihEL6nWsdJpWtuI2jOGFjsl8RgLpImWAKpZb2+eZYUw+Vjg9R
         4wo/TPf6zJ9/CWB7e8mybA07FOMWLuKI9BwZJQILnEAiFjnrwzZEEecV+v5/7fBWrrT2
         ieGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2YTMxBWhx7Otjnn8r5v7NzSq3gAYo+K8MrbMb1Wf8a4=;
        b=l+kj4cIxj8hF4Io0WccCSG/1K6GttPmUfagsAQVAT36Z+RTBdXCJSIRLt8vW1ZIdiR
         BMfHC0Oc0FqsQHlZjm0CHWpi5e+uuyJOtb0xaxhzr3UU0QbR4KMZeUcKdtwu0EsNbKn7
         jgrcMrq8tr0jB7k8XAk65xlhLgE0jddqZpSFbsRLdzwJeMhGlgJlzcwIKoO5jl9ib+9T
         Ej90QHL8jbwIXwmrpR9OrXvTHUHstwM9PFoIhYlfbnZHGsx3RvCUGucQ5bLbURCpvUnn
         c+o8cjBcYEdMiAeLXwrQeCf6jwDl1HKBtJ4Ovl7+8rMGoK0zyOMYXqHtlIgZixY9WsMi
         vnPA==
X-Gm-Message-State: APjAAAXMRsnZQji1dsu6OQaT4+RmKZdSFYqcRyXGnlWXvjbc4Ca20E8g
        2bw+5kfu5ZWwlMsDBQpAimxZLrm2H15RhL+cXya64w==
X-Google-Smtp-Source: APXvYqzQrpODphjkUzqVsGGqQnlP1a+JBKNbyESdvhjtt+/rfoCTjgBik4/Y5ODqVprjwiZ2S3sV1E4QPqOrz8SNne8=
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr1069517wmm.1.1579562295660;
 Mon, 20 Jan 2020 15:18:15 -0800 (PST)
MIME-Version: 1.0
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <20161202195416.58953-3-andriy.shevchenko@linux.intel.com>
 <20161215122856.7d24b7a8@endymion> <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
 <1481890738.9552.70.camel@linux.intel.com> <20161216143330.69e9c8ee@endymion>
 <20161217105721.GB6922@dhcp-128-65.nay.redhat.com> <20200120121927.GJ32742@smile.fi.intel.com>
 <87a76i9ksr.fsf@x220.int.ebiederm.org> <CAHp75VdjwWfqHtJ3n-UK_n5nzpgcpERbM+_9-Z3FrjJx7nHQzQ@mail.gmail.com>
In-Reply-To: <CAHp75VdjwWfqHtJ3n-UK_n5nzpgcpERbM+_9-Z3FrjJx7nHQzQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 21 Jan 2020 00:18:03 +0100
Message-ID: <CAKv+Gu-sVSWNYHEjzjOfbEryOR_XruwH=qQphq4uTXMLPK18tw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] firmware: dmi_scan: Pass dmi_entry_point to
 kexec'ed kernel
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 20 Jan 2020 at 23:31, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jan 20, 2020 at 9:28 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > > On Sat, Dec 17, 2016 at 06:57:21PM +0800, Dave Young wrote:
> > >> Ccing efi people.
> > >>
> > >> On 12/16/16 at 02:33pm, Jean Delvare wrote:
> > >> > On Fri, 16 Dec 2016 14:18:58 +0200, Andy Shevchenko wrote:
> > >> > > On Fri, 2016-12-16 at 10:32 +0800, Dave Young wrote:
> > >> > > > On 12/15/16 at 12:28pm, Jean Delvare wrote:
> > >> > > > > I am no kexec expert but this confuses me. Shouldn't the second
> > >> > > > > kernel have access to the EFI systab as the first kernel does? It
> > >> > > > > includes many more pointers than just ACPI and DMI tables, and it
> > >> > > > > would seem inconvenient to have to pass all these addresses
> > >> > > > > individually explicitly.
> > >> > > >
> > >> > > > Yes, in modern linux kernel, kexec has the support for EFI, I think it
> > >> > > > should work naturally at least in x86_64.
> > >> > >
> > >> > > Thanks for this good news!
> > >> > >
> > >> > > Unfortunately Intel Galileo is 32-bit platform.
> > >> >
> > >> > If it was done for X86_64 then maybe it can be generalized to X86?
> > >>
> > >> For X86_64, we have a new way for efi runtime memmory mapping, in i386
> > >> code it still use old ioremap way. It is impossible to use same way as
> > >> the X86_64 since the virtual address space is limited.
> > >>
> > >> But maybe for 32bit, kexec kernel can run in physical mode, but I'm not
> > >> sure, I would suggest Andy to do a test first with efi=noruntime for
> > >> kexec 2nd kernel.
> > >
> > > Guys, it was quite a long no hear from you. As I told you the proposed work
> > > around didn't help. Today I found that Microsoft Surface 3 also affected
> > > by this.
> > >
> > > Can we apply these patches for now until you will find better
> > > solution?
> >
> > Not a chance.  The patches don't apply to any kernel in the git history.
> >
> > Which may be part of your problem.  You are or at least were running
> > with code that has not been merged upstream.
>
> It's done against linux-next.
> Applied clearly. (Not the version in this more than yearly old series
> of course, that's why I told I can resend)
>
> > > P.S. I may resend them rebased on recent vanilla.
> >
> > Second.  I looked at your test results and they don't directly make
> > sense.  dmidecode bypasses the kernel completely or it did last time
> > I looked so I don't know why you would be using that to test if
> > something in the kernel is working.
> >
> > However dmidecode failing suggests that the actual problem is something
> > in the first kernel is stomping the dmi tables.
>
> See below.
>
> > Adding a command line option won't fix stomped tables.
>
> It provides a mechanism, which seems to be absent, to the second
> kernel to know where to look for SMBIOS tables.
>
> > So what I would suggest is:
> > a) Verify that dmidecode works before kexec.
>
> Yes, it does.
>
> > b) Test to see if dmidecode works after kexec.
>
> No, it doesn't.
>
> > c) Once (a) shows that dmidecode works and (b) shows that dmidecode
> >    fails figure out what is stomping your dmi tables during or before
> >    kexec and that is what should get fixed.
>
> The problem here as I can see it that EFI and kexec protocols are not
> friendly to each other.
> I'm not an expert in either. That's why I'm asking for possible
> solutions. And this needs to be done in kernel to allow drivers to
> work.
>
> Does the
>
> commit 4996c02306a25def1d352ec8e8f48895bbc7dea9
> Author: Takao Indoh <indou.takao@jp.fujitsu.com>
> Date:   Thu Jul 14 18:05:21 2011 -0400
>
>     ACPI: introduce "acpi_rsdp=" parameter for kdump
>
> description shed a light on this?
>
> > Now using a non-efi method of dmi detection relies on the
> > tables being between 0xF0000 and 0x10000. AKA the last 64K
> > of the first 1MiB of memory.  You might check to see if your
> > dmi tables are in that address range.
>
> # dmidecode --no-sysfs
> # dmidecode 3.2
> Scanning /dev/mem for entry point.
> # No SMBIOS nor DMI entry point found, sorry.
>
> === with patch applied ===
> # dmidecode
> ...
>         Release Date: 03/10/2015
> ...
>
> >
> > Otherwise I suspect the good solution is to give efi it's own page
> > tables in the kernel and switch to it whenever efi functions are called.
> >
>
> > But on 32bit the Linux kernel has historically been just fine directly
> > accessing the hardware, and ignoring efi and all of the other BIOS's.
>
> It seems not only for 32-bit Linux kernel anymore. MS Surface 3 runs
> 64-bit code.
>
> > So if that doesn't work on Intel Galileo that is probably a firmware
> > problem.
>
> It's not only about Galileo anymore.
>

Looking at the x86 kexec EFI code, it seems that it has special
handling for the legacy SMBIOS table address, but not for the SMBIOS3
table address, which was introduced to accommodate SMBIOS tables
living in memory that is not 32-bit addressable.

Could anyone check whether these systems provide SMBIOS 3.0 tables,
and whether their address gets virtually remapped at ExitBootServices?
