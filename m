Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0011DC38D
	for <lists+linux-efi@lfdr.de>; Thu, 21 May 2020 02:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgEUAYz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 20:24:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:28036 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbgEUAYz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 May 2020 20:24:55 -0400
IronPort-SDR: ouOLCdcmOVn49xOuMhy+3LxvJxPfi/nSDdp0CCvvoCXZIvZe7nI+Kwg62At8XO4dEUI/bkPrhB
 cilx/ZMocd7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 17:24:53 -0700
IronPort-SDR: xEOditTzw2CCYFmKj+V2z+qxO1Tf2q1/PdvHFbfdf1B5DVfLYYoLLuJvi+FZmb9V8GxYwXMpop
 ChtVKM4zcPEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,415,1583222400"; 
   d="scan'208";a="466582436"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga005.fm.intel.com with ESMTP; 20 May 2020 17:24:51 -0700
Date:   Thu, 21 May 2020 08:23:36 +0800
From:   Philip Li <philip.li@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Chen Rong <rong.a.chen@intel.com>
Subject: Re: [efi:next 22/40] ld.lld: warning:
 vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32
 against symbol ''
Message-ID: <20200521002336.GA15716@intel.com>
References: <202005201012.pqmB8hA5%lkp@intel.com>
 <20200520155352.GB3184088@rani.riverdale.lan>
 <CAMj1kXGNmDPQRCCtRYFRa+0NW9kADnx327FzPbNge+MU+NFoVg@mail.gmail.com>
 <20200520173425.ovn4kvv2cvkdlrnn@google.com>
 <20200520173926.GA3365034@rani.riverdale.lan>
 <20200520174100.GB3365034@rani.riverdale.lan>
 <CAKwvOdns1LkmPNAGcOZRdXxD_2fTgbYzr0DndvsTVL-Zuuowgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdns1LkmPNAGcOZRdXxD_2fTgbYzr0DndvsTVL-Zuuowgg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 20, 2020 at 10:56:28AM -0700, Nick Desaulniers wrote:
> On Wed, May 20, 2020 at 10:41 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > As an aside, how does one (should I) get onto kbuild-all? It keeps
> > bouncing me as a non-list member currently.
I think this is the setting of kbuild-all 01.org, you may need subscrible to
kbuild-all@lists.01.org mailing list to avoid this.

> 
> Philip Li <philip.li@intel.com>
> Chen Rong <rong.a.chen@intel.com>
> are the two folks I always reference for 0day bot related questions. I
> haven't seen bounces, but I also don't recall subscribing to any
> related mailing lists.  Maybe I was added to one?
Yes, and you can send mail to lkp@intel.com, which is the contact mail
that 0-day ci side is using.

> -- 
> Thanks,
> ~Nick Desaulniers
