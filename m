Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9AFD29606
	for <lists+linux-efi@lfdr.de>; Fri, 24 May 2019 12:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390268AbfEXKiv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 May 2019 06:38:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:37305 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390248AbfEXKiv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 May 2019 06:38:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 03:38:50 -0700
X-ExtLoop1: 1
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.189])
  by orsmga005.jf.intel.com with ESMTP; 24 May 2019 03:38:46 -0700
Date:   Fri, 24 May 2019 13:38:46 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Morris <jmorris@namei.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com, bsz@semihalf.com
Subject: Re: [PATCH V7 0/4] Add support for crypto agile logs
Message-ID: <20190524103846.GA11695@linux.intel.com>
References: <20190520205501.177637-1-matthewgarrett@google.com>
 <20190523121449.GA9997@linux.intel.com>
 <20190523122610.GA12327@linux.intel.com>
 <alpine.LRH.2.21.1905240252440.31508@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1905240252440.31508@namei.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 24, 2019 at 02:54:20AM +1000, James Morris wrote:
> On Thu, 23 May 2019, Jarkko Sakkinen wrote:
> 
> > On Thu, May 23, 2019 at 03:14:49PM +0300, Jarkko Sakkinen wrote:
> > > On Mon, May 20, 2019 at 01:54:57PM -0700, Matthew Garrett wrote:
> > > > Identical to previous version except without the KSAN workaround - Ard
> > > > has a better solution for that.
> > > 
> > > 
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Only applied to my master at this point becaues the patches from
> > my earlier PRs are not yet mirrored to security/next-general.
> 
> Which PRs are these?
> 
> btw, Linus wants security subsystem maintainers to submit PRs directly to 
> him from now on.
> 
> I'll only be carrying patches for the core LSM and new security mechanisms 
> before they're merged and have a maintainer assigned.

I'm referring to these:

https://lore.kernel.org/linux-integrity/20190329115544.GA27351@linux.intel.com/

I got response from you that those were applied and there is another
response in that thread that they are being sent to Linus. That is why I
haven't done anything since. Most of them are critical fixes to v5.1
changes.

Should I now take the action to send a PR to Linus and tag them to
stable?

/Jarkko
