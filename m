Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49C6AE3F6
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2019 08:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfIJGsc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Sep 2019 02:48:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44890 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbfIJGsc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Sep 2019 02:48:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id k6so5536201wrn.11;
        Mon, 09 Sep 2019 23:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1F/dA2/D5ciKZtnDXtUZl+0NQSD4CHNPFOdVSzSev+Q=;
        b=OFqjvAg+3QlFYOvYI6MBVXtCCq/vwVANKOcrqG9HAZ+vT9F4qVhb81bVty6+ri2K7e
         nGQwPbtEYmPUx7r8275VDATUbpOUscefIsIpApKKD135GPx/7HjqxE/GoaqzL3iHIT9v
         Lu/REsqNFA2VgQU6Jmba6nFfVySueUH05L57JdCNV8KAtyh7z4clav7DrBGzxVZeepEm
         XCkCh/M2h10X18C3rq1Tyqfcuw6YWd8E+AVkbaeWxmEoM4G13aZkrJfyVTqIhict3sxt
         wj0Gm9UzbrpXIWvX09J5lyYhz/ITwUby8eeZ9ICwlQsjI2tfA2YwRtPRLN0dS1IYjOMN
         5kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1F/dA2/D5ciKZtnDXtUZl+0NQSD4CHNPFOdVSzSev+Q=;
        b=Ts8SmDnZsSmLVI3+Oye4Howuafq8ZZeub4+mlDqYTZzzQgDuCdmhgx1oFhJusduD8T
         NTTz/Js5yzOXWO59abO1OlvwfNDeJ4uGOMEm6evj7p68QmATJQK07xr3tQK3oXo1RCFe
         nhoX85pxaZwMNfuTmCdH6vIARy9LMHvJqS94Cy0DyVEvF1HdfYsiOcvZayD7Kwm4+Xzj
         ehWrsdyBnHXztJq2O68FzZgnWhvM2J27qrUtVAz4kPCpZD/WhcWruSacayDGIfjRRA6y
         mwjZXdsMgKFnifw5X05XzKZNQMeBMaXYTTRQCp4NHHh8eJRkKRdvslvuKpTNvShL6pQo
         eSgw==
X-Gm-Message-State: APjAAAV/I9feNeXKM11NTl+r8QKOL+yqD56yhxdPZo6JLw7R4fUIPfsA
        Qe905y4DHFDfjcubPqtNA6A=
X-Google-Smtp-Source: APXvYqxfDZhX/nE/GheZIwbmzE69F2z/aC961bjub+DWwf4NfGRRD4wpPWl+wbIHfPK3F6qNCIAgew==
X-Received: by 2002:a5d:680e:: with SMTP id w14mr19464197wru.3.1568098108961;
        Mon, 09 Sep 2019 23:48:28 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 33sm16773541wra.41.2019.09.09.23.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 23:48:28 -0700 (PDT)
Date:   Tue, 10 Sep 2019 08:48:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     tglx@linutronix.de, rafael.j.wysocki@intel.com, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v5 05/10] x86, efi: Add efi_fake_mem support for
 EFI_MEMORY_SP
Message-ID: <20190910064826.GA23659@gmail.com>
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156712996407.1616117.11409311856083390862.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156712996407.1616117.11409311856083390862.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> Given that EFI_MEMORY_SP is platform BIOS policy descision for marking
> memory ranges as "reserved for a specific purpose" there will inevitably
> be scenarios where the BIOS omits the attribute in situations where it
> is desired. Unlike other attributes if the OS wants to reserve this
> memory from the kernel the reservation needs to happen early in init. So
> early, in fact, that it needs to happen before e820__memblock_setup()
> which is a pre-requisite for efi_fake_memmap() that wants to allocate
> memory for the updated table.
> 
> Introduce an x86 specific efi_fake_memmap_early() that can search for
> attempts to set EFI_MEMORY_SP via efi_fake_mem and update the e820 table
> accordingly.
> 
> The KASLR code that scans the command line looking for user-directed
> memory reservations also needs to be updated to consider
> "efi_fake_mem=nn@ss:0x40000" requests.
> 
> Cc: <x86@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

A couple of these patches are touching EFI code, but only the first one 
carries a Reviewed-by from Ard.

Ard, are these patches and the whole series fine with you?

Thanks,

	Ingo
