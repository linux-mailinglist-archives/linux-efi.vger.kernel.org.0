Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5184DCA9
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2019 23:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfFTVhx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Jun 2019 17:37:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:34601 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfFTVhx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Jun 2019 17:37:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 14:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,398,1557212400"; 
   d="scan'208";a="162491010"
Received: from mudigirx-mobl1.gar.corp.intel.com (HELO localhost) ([10.252.61.12])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jun 2019 14:37:48 -0700
Date:   Fri, 21 Jun 2019 00:37:46 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        tpmdd-devel@lists.sourceforge.net,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: firmware: efi: fix gcc warning -Wint-conversion
Message-ID: <20190620213722.GA17841@linux.intel.com>
References: <20190615040210.GA9112@hari-Inspiron-1545>
 <CAKv+Gu9-wiJNxPsVn06dBSU8Gchg8LjV=mi0cThZUWywmt2xzQ@mail.gmail.com>
 <CACdnJuudmE-MNuO7z87Mm65VaXbRzhOrBEpU5F=yC67uSLytGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACdnJuudmE-MNuO7z87Mm65VaXbRzhOrBEpU5F=yC67uSLytGQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 19, 2019 at 03:48:23PM -0700, Matthew Garrett wrote:
> On Wed, Jun 19, 2019 at 2:55 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > (+ Jarkko, tpmdd, Matthew)
> >
> > On Sat, 15 Jun 2019 at 06:02, Hariprasad Kelam
> > <hariprasad.kelam@gmail.com> wrote:
> > >
> > > This patch fixes below warning
> > >
> > > drivers/firmware/efi/tpm.c:78:38: warning: passing argument 1 of
> > > ‘tpm2_calc_event_log_size’ makes pointer from integer without a cast
> > > [-Wint-conversion]
> > >
> > > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> >
> > I think we already have a fix queued for this, no?
> 
> It looks like I fixed this in "Don't duplicate events from the final
> event log in the TCG2 log" rather than a separate patch - I'm fine
> merging this, based on Jarkko's preferences.

Right! OK, I squashed just the fix to the earlier patch. Master and
next are updated. Can you take a peek of [1] and see if it looks
legit given all the fuzz around these changes? Then I'm confident
enough to do the 5.3 PR.

[1] git://git.infradead.org/users/jjs/linux-tpmdd.git

/Jarkko
