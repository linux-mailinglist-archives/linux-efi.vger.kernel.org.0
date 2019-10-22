Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60045E099C
	for <lists+linux-efi@lfdr.de>; Tue, 22 Oct 2019 18:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbfJVQsZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Oct 2019 12:48:25 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39687 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731707AbfJVQsZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Oct 2019 12:48:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id s22so14776904otr.6
        for <linux-efi@vger.kernel.org>; Tue, 22 Oct 2019 09:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+6No+BxgIjHWFQl8mEre5geCrP8fi/EeYgiUXvYmaQ=;
        b=s6UgbS4ygkuYPcJAAz3pNE7NObfVgWrxILYPPMZ64u/k26Tlh6VILXVknF/EVXamYW
         JfGqLPtKv0uhIS82q3cjRbmSV68r0gXlRmOSju0sYhJbF19LHXbbiaJ1L9AhhaKRTiKP
         7Nmc/i7KXYTM75gzn8DB3Ffy4pCr6Gj5U2IhXd6VogFuoho9HkbeTx34hgnfHaDpxJ6R
         F2vb0qYVbMjW7271kotp9FaczmghmLyL0qHzn7+ppM77aAE1H8W4VMzOgeKAVFZVDeIY
         ZTJYmyN1FW5YCH4xLwCspopHQI0elv9i01FAWMh92jB+mTr1bnUOm41F0QAuqBnvll+T
         N/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+6No+BxgIjHWFQl8mEre5geCrP8fi/EeYgiUXvYmaQ=;
        b=cVeqYEqUSu/wPUbNutQ+MU29u2+hjyArPORiOzA+YGLC9WoKIHFV6Ty0h2XVatMZpf
         Yc+r0X0CU7JNsXwDVdvSormxD5fA5TSS9O3Z7gu9FnvjNbqwwAnicMspidi2/aiL9CF2
         aF9C6elqWztXQlnZpIwouXk7M5ENPHejBseHlKscV9WEWiUIk/POdagBaLJ3NI1a4RDG
         +R2XSy2gtAifw0ihfIlC5wUbK6CNf2HmQc0BIP2KCEEHnBABOR+G0ncQZykuKsOYmncV
         C5VNU7iXpzzo6d6/RhzVvEDQaEOLuRUFsOLsJ07tBznq2SVY/91X0QYYHRcd5DwjhFur
         kPMA==
X-Gm-Message-State: APjAAAXbxxr9EQN4EnGNWzRvUUcPr8fnLWZf1qaweKIq3A9UYeUl2OvE
        3Ny0MpcxRjASweQBx7F6U/eEtQ73kLo6ICNqPlv37A==
X-Google-Smtp-Source: APXvYqwtw7FLGKUJW5VN/z168Ax4kCyZdkZTBUWqQLVn8w1bS74nzE4bXxhqmn24Xtn3tFVuwIDJyV6Rl48d61eRmdU=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr3564630otb.126.1571762904646;
 Tue, 22 Oct 2019 09:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157118757175.2063440.9248947575330904096.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0i-hhasNCD6Ur8VLfrkc+4GOeNXXX_ZNFZjcY6F51ciSQ@mail.gmail.com> <CAJZ5v0j_-iSqiysZiW=J8Y5FCAjnPC7ZvevrLsYhngWr6mT6GQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j_-iSqiysZiW=J8Y5FCAjnPC7ZvevrLsYhngWr6mT6GQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 22 Oct 2019 09:48:12 -0700
Message-ID: <CAPcyv4js1XqSe1kNeWob=ftscYFKQF+04PrKj7XDiEWUWvnMvQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] acpi/numa: Establish a new drivers/acpi/numa/ directory
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 22, 2019 at 3:02 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Oct 18, 2019 at 11:25 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> >  On Wed, Oct 16, 2019 at 3:13 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > Currently hmat.c lives under an "hmat" directory which does not enhance
> > > the description of the file. The initial motivation for giving hmat.c
> > > its own directory was to delineate it as mm functionality in contrast to
> > > ACPI device driver functionality.
> > >
> > > As ACPI continues to play an increasing role in conveying
> > > memory location and performance topology information to the OS take the
> > > opportunity to co-locate these NUMA relevant tables in a combined
> > > directory.
> > >
> > > numa.c is renamed to srat.c and moved to drivers/acpi/numa/ along with
> > > hmat.c.
> > >
> > > Cc: Len Brown <lenb@kernel.org>
> > > Cc: Keith Busch <kbusch@kernel.org>
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > Please note that https://patchwork.kernel.org/patch/11078171/ is being
> > pushed to Linus (it is overdue anyway), so if it is pulled, there will
> > be a merge conflict with this patch.
> >
> > Respin maybe?
>
> Actually, would you mind it if I took this one into the ACPI tree right away?
>
> There's https://patchwork.kernel.org/patch/11198373/ queued up that,
> again, will clash with it.
>
> Also, there is the generic Initiator proximity domains series from
> Jonathan depending on it and I would like to move forward with that
> one if there are no objections.

Given Ard has acked all the EFI core and ARM changes can we proceed
with merging the EFI Specific Purpose Memory series through Rafael's
tree? It would need acks from x86 maintainers.
