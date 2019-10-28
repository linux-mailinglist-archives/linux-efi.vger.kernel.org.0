Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2849E74A0
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2019 16:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390570AbfJ1PMx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Oct 2019 11:12:53 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60193 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbfJ1PMx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Oct 2019 11:12:53 -0400
Received: from cust-east-parth2-46-193-72-114.wb.wifirst.net (46.193.72.114) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 83bf5fa78bdd09e1; Mon, 28 Oct 2019 16:12:50 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 01/12] acpi/numa: Establish a new drivers/acpi/numa/ directory
Date:   Mon, 28 Oct 2019 16:12:49 +0100
Message-ID: <1666116.19LcctqB44@kreacher>
In-Reply-To: <CAPcyv4js1XqSe1kNeWob=ftscYFKQF+04PrKj7XDiEWUWvnMvQ@mail.gmail.com>
References: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com> <CAJZ5v0j_-iSqiysZiW=J8Y5FCAjnPC7ZvevrLsYhngWr6mT6GQ@mail.gmail.com> <CAPcyv4js1XqSe1kNeWob=ftscYFKQF+04PrKj7XDiEWUWvnMvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tuesday, October 22, 2019 6:48:12 PM CET Dan Williams wrote:
> On Tue, Oct 22, 2019 at 3:02 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Oct 18, 2019 at 11:25 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > >  On Wed, Oct 16, 2019 at 3:13 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > Currently hmat.c lives under an "hmat" directory which does not enhance
> > > > the description of the file. The initial motivation for giving hmat.c
> > > > its own directory was to delineate it as mm functionality in contrast to
> > > > ACPI device driver functionality.
> > > >
> > > > As ACPI continues to play an increasing role in conveying
> > > > memory location and performance topology information to the OS take the
> > > > opportunity to co-locate these NUMA relevant tables in a combined
> > > > directory.
> > > >
> > > > numa.c is renamed to srat.c and moved to drivers/acpi/numa/ along with
> > > > hmat.c.
> > > >
> > > > Cc: Len Brown <lenb@kernel.org>
> > > > Cc: Keith Busch <kbusch@kernel.org>
> > > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > >
> > > Please note that https://patchwork.kernel.org/patch/11078171/ is being
> > > pushed to Linus (it is overdue anyway), so if it is pulled, there will
> > > be a merge conflict with this patch.
> > >
> > > Respin maybe?
> >
> > Actually, would you mind it if I took this one into the ACPI tree right away?
> >
> > There's https://patchwork.kernel.org/patch/11198373/ queued up that,
> > again, will clash with it.
> >
> > Also, there is the generic Initiator proximity domains series from
> > Jonathan depending on it and I would like to move forward with that
> > one if there are no objections.
> 
> Given Ard has acked all the EFI core and ARM changes can we proceed
> with merging the EFI Specific Purpose Memory series through Rafael's
> tree? It would need acks from x86 maintainers.

In the face of the lack of responses here, I think I will apply this patch
alone and expose a stable branch containing it in case somebody else wants
to pull it in.

Thanks!




