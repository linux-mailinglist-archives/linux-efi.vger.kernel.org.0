Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF313E0173
	for <lists+linux-efi@lfdr.de>; Tue, 22 Oct 2019 12:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfJVKBy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Oct 2019 06:01:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39759 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKBx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Oct 2019 06:01:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id w144so13656852oia.6;
        Tue, 22 Oct 2019 03:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QymUh+Fku1vQVHvu/DETUtAo+Qu6b8CnaBuQss7KKWQ=;
        b=h2iFRY8kvTIp3uSv1xdak5KNpDhBffU8tz5cQttN6wCNauPnlPr4C5ZPCzDK5CEjVa
         Jxoa41P5dwq9bKhkzqx0Lhpe3IpS9iFh9cyJ3exTdWgUzJ6R+9ID9etOk3itNUlrar2D
         XYT0qtXndeRj9xZtnfwNHPtyn0MofhuSzR1VX+og2nVBKLSnEFyMwBpZeIHjZ8WPEg5K
         TRHJZ9fOqANYXYSxnM2D98uyiYJbtjOwM5X9RI90k+PrtRht3xEJJhiPmQx7AT9si9UM
         hA1O2FwqFUJUiCozB/kw6xe9MWnkXAuC990fm+qCTFujfjkbLRyGorM16gj6rzx+yPZA
         07tw==
X-Gm-Message-State: APjAAAWTo+kUSUZW11FBs6JEIIRg89XQoX2SG8iweGe3VcITONwczN4m
        pCbAufSGXt3fuEq6mWhOJ1bXI0QjGhu5O60Zt6M=
X-Google-Smtp-Source: APXvYqwN0bxJxdIvFNnaNORZKQBNabY4ldLgTUIlNjE1Z7rAnNoVLH34CBEzb2jBIdbGQUA6pt46njyJIVaN1WsCNSA=
X-Received: by 2002:aca:d405:: with SMTP id l5mr2047939oig.115.1571738512905;
 Tue, 22 Oct 2019 03:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157118757175.2063440.9248947575330904096.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0i-hhasNCD6Ur8VLfrkc+4GOeNXXX_ZNFZjcY6F51ciSQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i-hhasNCD6Ur8VLfrkc+4GOeNXXX_ZNFZjcY6F51ciSQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Oct 2019 12:01:42 +0200
Message-ID: <CAJZ5v0j_-iSqiysZiW=J8Y5FCAjnPC7ZvevrLsYhngWr6mT6GQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] acpi/numa: Establish a new drivers/acpi/numa/ directory
To:     Dan Williams <dan.j.williams@intel.com>
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 18, 2019 at 11:25 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  On Wed, Oct 16, 2019 at 3:13 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Currently hmat.c lives under an "hmat" directory which does not enhance
> > the description of the file. The initial motivation for giving hmat.c
> > its own directory was to delineate it as mm functionality in contrast to
> > ACPI device driver functionality.
> >
> > As ACPI continues to play an increasing role in conveying
> > memory location and performance topology information to the OS take the
> > opportunity to co-locate these NUMA relevant tables in a combined
> > directory.
> >
> > numa.c is renamed to srat.c and moved to drivers/acpi/numa/ along with
> > hmat.c.
> >
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Please note that https://patchwork.kernel.org/patch/11078171/ is being
> pushed to Linus (it is overdue anyway), so if it is pulled, there will
> be a merge conflict with this patch.
>
> Respin maybe?

Actually, would you mind it if I took this one into the ACPI tree right away?

There's https://patchwork.kernel.org/patch/11198373/ queued up that,
again, will clash with it.

Also, there is the generic Initiator proximity domains series from
Jonathan depending on it and I would like to move forward with that
one if there are no objections.
