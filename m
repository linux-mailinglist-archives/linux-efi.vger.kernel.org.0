Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC52B2B78A
	for <lists+linux-efi@lfdr.de>; Mon, 27 May 2019 16:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfE0ObY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 May 2019 10:31:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:49805 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfE0ObY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 27 May 2019 10:31:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 07:31:24 -0700
X-ExtLoop1: 1
Received: from pgomulkx-mobl.ger.corp.intel.com (HELO localhost) ([10.251.94.230])
  by orsmga002.jf.intel.com with ESMTP; 27 May 2019 07:31:18 -0700
Date:   Mon, 27 May 2019 17:31:03 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Morris <jmorris@namei.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com, bsz@semihalf.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH V7 0/4] Add support for crypto agile logs
Message-ID: <20190527143103.GA20497@linux.intel.com>
References: <20190520205501.177637-1-matthewgarrett@google.com>
 <20190523121449.GA9997@linux.intel.com>
 <20190523122610.GA12327@linux.intel.com>
 <alpine.LRH.2.21.1905240252440.31508@namei.org>
 <20190524103846.GA11695@linux.intel.com>
 <alpine.LRH.2.21.1905250506320.7233@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1905250506320.7233@namei.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, May 25, 2019 at 05:22:34AM +1000, James Morris wrote:
> On Fri, 24 May 2019, Jarkko Sakkinen wrote:
> 
> > I'm referring to these:
> > 
> > https://lore.kernel.org/linux-integrity/20190329115544.GA27351@linux.intel.com/
> > 
> > I got response from you that those were applied and there is another
> > response in that thread that they are being sent to Linus. That is why I
> > haven't done anything since. Most of them are critical fixes to v5.1
> > changes.
> 
> These are in Linus' tree.  
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a556810d8e06aa2da8bbe22da3d105eb5a0d0c7d
> 
> I initially queued them in the next-tpm branch, but forgot to drop them 
> from there after sending them to Linus as a v5.1 fix. Linus was not happy 
> to see them again in the v5.2 merge window.
> 
> Apologies for the confusion.

OK, just to confirm, my next PR will go straight to Linus?

/Jarkko
