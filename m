Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E06B8A1B4C
	for <lists+linux-efi@lfdr.de>; Thu, 29 Aug 2019 15:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfH2NWK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 29 Aug 2019 09:22:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:35706 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfH2NWK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 29 Aug 2019 09:22:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 06:22:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="171893560"
Received: from friedlmi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.54.26])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2019 06:22:03 -0700
Date:   Thu, 29 Aug 2019 16:21:57 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Peter Jones <pjones@redhat.com>
Cc:     Matthew Garrett <mjg59@google.com>, ard.biesheuvel@linaro.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Lyude Paul <lyude@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] efi+tpm: Don't access event->count when it isn't
 mapped.
Message-ID: <20190829132136.cipjjqcxmrqs2sp7@linux.intel.com>
References: <20190826153028.32639-1-pjones@redhat.com>
 <20190826162823.4mxkwhd7mbtro3zy@linux.intel.com>
 <CACdnJuuB_ExhOOtA8Uh7WO42TSNfRHuGaK4Xo=5SbdfWDKr7wA@mail.gmail.com>
 <20190827110344.4uvjppmkkaeex3mk@linux.intel.com>
 <20190827134155.otm6ekeb53siy6lb@linux.intel.com>
 <20190827221157.mngkglcgj4azux7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827221157.mngkglcgj4azux7b@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 27, 2019 at 06:11:58PM -0400, Peter Jones wrote:
> On Tue, Aug 27, 2019 at 04:41:55PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Aug 27, 2019 at 02:03:44PM +0300, Jarkko Sakkinen wrote:
> > > > Jarkko, these two should probably go to 5.3 if possible - I
> > > > independently had a report of a system hitting this issue last week
> > > > (Intel apparently put a surprising amount of data in the event logs on
> > > > the NUCs).
> > > 
> > > OK, I can try to push them. I'll do PR today.
> > 
> > Ard, how do you wish these to be managed?
> > 
> > I'm asking this because:
> > 
> > 1. Neither patch was CC'd to linux-integrity.
> > 2. Neither patch has your tags ATM.
> 
> I think Ard's not back until September.  I can just to re-send them with
> the accumulated tags and Cc linux-integrity, if you think that would
> help?

I take the risk. If possible, add all the cumulated tags to those
patches...

/Jarkko
