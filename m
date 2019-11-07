Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0325EF3061
	for <lists+linux-efi@lfdr.de>; Thu,  7 Nov 2019 14:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbfKGNtO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Nov 2019 08:49:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47793 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbfKGNtO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Nov 2019 08:49:14 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSi9a-0006t4-BI; Thu, 07 Nov 2019 14:48:50 +0100
Date:   Thu, 7 Nov 2019 14:48:49 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <kbusch@kernel.org>, Len Brown <lenb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        kbuild test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Lutomirski <luto@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v8 00/12] EFI Specific Purpose Memory Support
In-Reply-To: <CAJZ5v0hDaxcPBwwx2FaxKKJGNOvY_+JuvF7CJ0tbX1TjEisvUQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911071447090.4256@nanos.tec.linutronix.de>
References: <157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com> <CAJZ5v0hDaxcPBwwx2FaxKKJGNOvY_+JuvF7CJ0tbX1TjEisvUQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 7 Nov 2019, Rafael J. Wysocki wrote:
> On Thu, Nov 7, 2019 at 2:57 AM Dan Williams <dan.j.williams@intel.com> wrote:
> 
> Indeed.
> 
> I have waited for comments on x86 bits from Thomas, but since they are
> not coming, I have just decided to take patch [1/12] from this series,
> which should be totally non-controversial,  as keeping it out of the
> tree has become increasingly painful (material depending on it has
> been piling up already for some time).

Sorry for letting this slip through the cracks.

From x86 side I don't see any issues. It's mostly EFI stuff which Ard has
looked at already. So feel free to pick up the lot

Acked-by: Thomas Gleixner <tglx@linutronix.de>

