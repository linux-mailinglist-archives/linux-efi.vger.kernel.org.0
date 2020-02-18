Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D505163082
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2020 20:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgBRTq2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Feb 2020 14:46:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:32453 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgBRTq2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 Feb 2020 14:46:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 11:46:27 -0800
X-IronPort-AV: E=Sophos;i="5.70,457,1574150400"; 
   d="scan'208";a="315164534"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 11:46:26 -0800
Date:   Tue, 18 Feb 2020 11:46:25 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 00/18] efi: clean up contents of struct efi
Message-ID: <20200218194625.GA25459@agluck-desk2.amr.corp.intel.com>
References: <20200216182334.8121-1-ardb@kernel.org>
 <CAKv+Gu-4N6B0LPL1fn5C2EAh9y3ECZ=mSi92p0AyJf67mJoWmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-4N6B0LPL1fn5C2EAh9y3ECZ=mSi92p0AyJf67mJoWmw@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Feb 16, 2020 at 07:31:58PM +0100, Ard Biesheuvel wrote:
> (+ Tony and Fenghua)
> 
> Apologies to the IA64 maintainers for forgetting to cc you.

No worries.
> 
> The whole series can be found at
> https://lore.kernel.org/linux-efi/20200216182334.8121-1-ardb@kernel.org/
> 
> Please let me know if you need me to resend with the missing cc's added.

Thanks to get-lore-mbox.py I don't. It picked up all the pieces.

It all builds and boots with no issues.

Looks like a nice cleanup.

Tested-by: Tony Luck <tony.luck@intel.com> # arch/ia64

-Tony
