Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF94B9E9B1
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2019 15:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfH0Nl7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Aug 2019 09:41:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:64187 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfH0Nl6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 27 Aug 2019 09:41:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 06:41:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="204973364"
Received: from jsakkine-mobl1.fi.intel.com (HELO localhost) ([10.237.66.169])
  by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2019 06:41:55 -0700
Date:   Tue, 27 Aug 2019 16:41:55 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <mjg59@google.com>, ard.biesheuvel@linaro.org
Cc:     Peter Jones <pjones@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Lyude Paul <lyude@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] efi+tpm: Don't access event->count when it isn't
 mapped.
Message-ID: <20190827134155.otm6ekeb53siy6lb@linux.intel.com>
References: <20190826153028.32639-1-pjones@redhat.com>
 <20190826162823.4mxkwhd7mbtro3zy@linux.intel.com>
 <CACdnJuuB_ExhOOtA8Uh7WO42TSNfRHuGaK4Xo=5SbdfWDKr7wA@mail.gmail.com>
 <20190827110344.4uvjppmkkaeex3mk@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827110344.4uvjppmkkaeex3mk@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 27, 2019 at 02:03:44PM +0300, Jarkko Sakkinen wrote:
> > Jarkko, these two should probably go to 5.3 if possible - I
> > independently had a report of a system hitting this issue last week
> > (Intel apparently put a surprising amount of data in the event logs on
> > the NUCs).
> 
> OK, I can try to push them. I'll do PR today.

Ard, how do you wish these to be managed?

I'm asking this because:

1. Neither patch was CC'd to linux-integrity.
2. Neither patch has your tags ATM.

/Jarkko
