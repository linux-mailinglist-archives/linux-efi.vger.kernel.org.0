Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7C843109C
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2019 16:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfEaOwh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 May 2019 10:52:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45374 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfEaOwg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 May 2019 10:52:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id t24so9406029otl.12
        for <linux-efi@vger.kernel.org>; Fri, 31 May 2019 07:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dazNgH0WSo6RBdntgfM2itxBiI4ct6zLibwem/T/a7w=;
        b=j/GsBEIAjVbZy5Y3mimHxH4kZFIlLlKkT8Acinmv2sLTumtJSAz4+K45i94HMcU8B5
         5vuoBjVllo8eLWfIEEGmSHN3y18C2+WtOf2ld9xfh/eBfNzfI08ywejx6/WFhh2Qh1Js
         U/xC31+TIvuIg3zpSPwdusI6fAgBAbuf9ZVsZWxcMq9qesaxUCnyu+Jm/j/acoKaQrVk
         /xZ6KTMGmaqDluJACKDkBZki6qenzP6ucLDP6nqi5PMISHPe9me9sBfBu16SCQ9MmPmY
         x6x0pxCLwDJjV9HwPASaVKILGYScIoM8oWLKnlfoOZ9C4wOlTg6towcaz/+2kExeQ+Ur
         a5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dazNgH0WSo6RBdntgfM2itxBiI4ct6zLibwem/T/a7w=;
        b=VJ4IspvEttbl8szLlR6MRwbNJ0HTOSc/RAnnUDwxk9s5bUj0AJpuSB8sK7qeCXJhZ2
         utNTFx9+I6KtyyCW+qyPfopTNBndHP95YcrVmkE+IufO6Wf2hAUyqLX9Y96fyHNFPqaf
         jme7D81L1z7dtfNvPBZ0p5a4TFye+ZHjmJ3+c33f9Ge0PSnE2B2FOtRRS2waT2qgYkRe
         EcJxmnO+TSbfoVNDbqJhy8KBkIHZpLjbqua6shh+TbrQaFY399Gt2wJV3JEO6QawBk7m
         KpVptm7OMympHYH7VJq1vkf/FZOqaG9pvYzAdihI/y/ltKUQa9IWPg5uP+1tQRq9sCL4
         LHVg==
X-Gm-Message-State: APjAAAXgTkrMk9Av5ro76VTxxrM3MXx5QTzm2aLNDlkAGQYtq39U4Jxl
        I0bqiT6Bs5iwLsVs0QEJCSDxbjauUzt7R7I3AM33qQ==
X-Google-Smtp-Source: APXvYqz4eQwsdM8n+GXsG5v0XO/vAmXg8NEkFxvIGNZys/6jEKVlKq5wCfwFwo8AbFTYskZ23wp82lAK4anye2kHMfM=
X-Received: by 2002:a05:6830:1417:: with SMTP id v23mr1948581otp.71.1559314356156;
 Fri, 31 May 2019 07:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155925716783.3775979.13301455166290564145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <4965161.Uu1Nigf0I0@kreacher>
In-Reply-To: <4965161.Uu1Nigf0I0@kreacher>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 31 May 2019 07:52:24 -0700
Message-ID: <CAPcyv4ib1twvDBz6W=JU18JyvtYmyHeAU4iOruRGHf_cY+3Yvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] acpi: Drop drivers/acpi/hmat/ directory
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-efi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 31, 2019 at 1:24 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Friday, May 31, 2019 12:59:27 AM CEST Dan Williams wrote:
> > As a single source file object there is no need for the hmat enabling to
> > have its own directory.
>
> Well, I asked Keith to add that directory as the code in hmat.c is more related to mm than to
> the rest of the ACPI subsystem.

...but hmat/hmat.c does not say anything about mm?

> Is there any problem with retaining it?

It feels redundant for no benefit to type hmat/hmat.c. How about create:

    drivers/acpi/numa/ or drivers/acpi/mm/

...and move numa.c and hmat.c there if you want to separate mm
concerns from the rest of drivers/acpi/?
