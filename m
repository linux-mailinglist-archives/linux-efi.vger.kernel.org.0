Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B3643895
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2019 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbfFMPGy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jun 2019 11:06:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:18070 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732402AbfFMOGr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 Jun 2019 10:06:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 07:06:46 -0700
X-ExtLoop1: 1
Received: from bbouchn-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.22])
  by orsmga007.jf.intel.com with ESMTP; 13 Jun 2019 07:06:44 -0700
Date:   Thu, 13 Jun 2019 17:06:43 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter =?iso-8859-1?Q?H=FCwe?= <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Joe Richey <joerichey@google.com>
Subject: Re: [PATCH V2 2/2] tpm: Don't duplicate events from the final event
 log in the TCG2 log
Message-ID: <20190613140643.GE12791@linux.intel.com>
References: <20190607205147.102904-1-matthewgarrett@google.com>
 <20190607205147.102904-2-matthewgarrett@google.com>
 <CAKv+Gu-Vz8OSspw9RdEnVj3e7GFaNdA9PVVMWY2RKkEDfAbuRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-Vz8OSspw9RdEnVj3e7GFaNdA9PVVMWY2RKkEDfAbuRA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 07, 2019 at 11:11:21PM +0200, Ard Biesheuvel wrote:
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Ard, is it cool if I include these to my next TPM PR along with the
other Matthew's changes? Just sanity checking given that crossing
subsystems...

/Jarkko
