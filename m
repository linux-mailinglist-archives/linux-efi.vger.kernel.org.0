Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D75811BD8D
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2019 21:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLKUAN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Dec 2019 15:00:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:18900 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfLKUAN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 11 Dec 2019 15:00:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 12:00:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,303,1571727600"; 
   d="scan'208";a="215884859"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 11 Dec 2019 12:00:07 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1if89X-0005NU-R6; Wed, 11 Dec 2019 22:00:07 +0200
Date:   Wed, 11 Dec 2019 22:00:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] efi/earlycon: Fix write-combine mapping on x86
Message-ID: <20191211200007.GB32742@smile.fi.intel.com>
References: <20191210232410.17890-1-nivedita@alum.mit.edu>
 <CAKv+Gu8s=kT_21WasEsTRh+6COQYD0mpzOT5n0qhD1Y+YdR3JQ@mail.gmail.com>
 <20191211110435.GP32742@smile.fi.intel.com>
 <20191211173746.GA220404@rani.riverdale.lan>
 <20191211180330.GZ32742@smile.fi.intel.com>
 <CAKv+Gu8TbPg_SGZvTc+ZHgTnAq9zYtei7ZgqpdHv=5nNpW4j1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8TbPg_SGZvTc+ZHgTnAq9zYtei7ZgqpdHv=5nNpW4j1Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 11, 2019 at 06:06:28PM +0000, Ard Biesheuvel wrote:
> On Wed, 11 Dec 2019 at 19:03, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Dec 11, 2019 at 12:37:46PM -0500, Arvind Sankar wrote:

> > Perhaps comment near to if can explain this.

> I'm fine with the ternary, actually. What do you feel is wrong with it?

I don't like ternary when it takes more than one line. I found them hard to
follow.

It's anyway style, so, go ahead with it.

-- 
With Best Regards,
Andy Shevchenko


