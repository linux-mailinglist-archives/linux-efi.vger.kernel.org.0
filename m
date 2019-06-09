Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A773ABB4
	for <lists+linux-efi@lfdr.de>; Sun,  9 Jun 2019 21:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfFITxl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 9 Jun 2019 15:53:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:43728 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbfFITxl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 9 Jun 2019 15:53:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jun 2019 12:53:40 -0700
X-ExtLoop1: 1
Received: from nbylina-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.34.102])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jun 2019 12:53:38 -0700
Date:   Sun, 9 Jun 2019 22:53:37 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-efi@vger.kernel.org, ard.biesheuvel@linaro.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] efi: Fix TPM code build failure on ARM
Message-ID: <20190609195337.GA25074@linux.intel.com>
References: <20190605181140.35559-1-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605181140.35559-1-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 05, 2019 at 11:11:40AM -0700, Matthew Garrett wrote:
> asm/early_ioremap.h needs to be #included before tpm_eventlog.h in order
> to ensure that early_memremap is available.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

Thanks, squashed to "tpm: Reserve the TPM final events table".

/Jarkko
