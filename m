Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49F7E43894
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2019 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbfFMPGy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jun 2019 11:06:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:28342 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732400AbfFMOEo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 Jun 2019 10:04:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 07:04:43 -0700
X-ExtLoop1: 1
Received: from bbouchn-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.22])
  by orsmga007.jf.intel.com with ESMTP; 13 Jun 2019 07:04:40 -0700
Date:   Thu, 13 Jun 2019 17:04:40 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-efi@vger.kernel.org, ard.biesheuvel@linaro.org,
        Matthew Garrett <mjg59@google.com>,
        Joe Richey <joerichey@google.com>
Subject: Re: [PATCH V2 2/2] tpm: Don't duplicate events from the final event
 log in the TCG2 log
Message-ID: <20190613140440.GD12791@linux.intel.com>
References: <20190607205147.102904-1-matthewgarrett@google.com>
 <20190607205147.102904-2-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607205147.102904-2-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 07, 2019 at 01:51:47PM -0700, Matthew Garrett wrote:
> After the first call to GetEventLog() on UEFI systems using the TCG2
> crypto agile log format, any further log events (other than those
> triggered by ExitBootServices()) will be logged in both the main log and
> also in the Final Events Log. While the kernel only calls GetEventLog()
> immediately before ExitBootServices(), we can't control whether earlier
> parts of the boot process have done so. This will result in log entries
> that exist in both logs, and so the current approach of simply appending
> the Final Event Log to the main log will result in events being
> duplicated.
> 
> We can avoid this problem by looking at the size of the Final Event Log
> just before we call ExitBootServices() and exporting this to the main
> kernel. The kernel can then skip over all events that occured before
> ExitBootServices() and only append events that were not also logged to
> the main log.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Reported-by: Joe Richey <joerichey@google.com>
> Suggested-by: Joe Richey <joerichey@google.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
