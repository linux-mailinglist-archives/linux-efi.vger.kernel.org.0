Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0661B37845
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2019 17:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfFFPkQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jun 2019 11:40:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:38731 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbfFFPkQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 6 Jun 2019 11:40:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 08:40:15 -0700
X-ExtLoop1: 1
Received: from harend-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.8])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2019 08:40:12 -0700
Date:   Thu, 6 Jun 2019 18:40:07 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-efi@vger.kernel.org, ard.biesheuvel@linaro.org,
        Matthew Garrett <mjg59@google.com>,
        Joe Richey <joerichey@google.com>
Subject: Re: [PATCH V2] tpm: Don't duplicate events from the final event log
 in the TCG2 log
Message-ID: <20190606153951.GC25112@linux.intel.com>
References: <20190605180515.25326-1-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605180515.25326-1-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 05, 2019 at 11:05:15AM -0700, Matthew Garrett wrote:
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
