Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A840B11575
	for <lists+linux-efi@lfdr.de>; Thu,  2 May 2019 10:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfEBIco (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 May 2019 04:32:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:47842 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfEBIcn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 2 May 2019 04:32:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 01:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,421,1549958400"; 
   d="scan'208";a="145370147"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.189])
  by fmsmga008.fm.intel.com with ESMTP; 02 May 2019 01:32:40 -0700
Date:   Thu, 2 May 2019 11:32:40 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Bartosz Szczepanek <bsz@semihalf.com>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V5 2/4] tpm: Reserve the TPM final events table
Message-ID: <20190502083240.GJ14532@linux.intel.com>
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190227202658.197113-3-matthewgarrett@google.com>
 <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Apr 30, 2019 at 03:07:09PM +0200, Bartosz Szczepanek wrote:
> I may be a little late with this comment, but I've just tested these
> patches on aarch64 platform (from the top of jjs/master) and got
> kernel panic ("Unable to handle kernel read", full log at the end of
> mail). I think there's problem with below call to
> tpm2_calc_event_log_size(), where physical address of efi.tpm_log is
> passed as (void *) and never remapped:

Not late. This is not part of any PR yet. Thank you for the
feedback!

Matthew, can you send an updated version of the whole patch set
with fixes to this issue and also reordering of the includes?

/Jarkko
