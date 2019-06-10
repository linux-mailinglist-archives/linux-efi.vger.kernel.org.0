Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D065A3BA36
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2019 18:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfFJQ6c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jun 2019 12:58:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:9948 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbfFJQ6c (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Jun 2019 12:58:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 09:58:31 -0700
X-ExtLoop1: 1
Received: from cmargarx-wtg.ger.corp.intel.com (HELO localhost) ([10.249.34.77])
  by orsmga003.jf.intel.com with ESMTP; 10 Jun 2019 09:58:25 -0700
Date:   Mon, 10 Jun 2019 19:58:19 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-efi@vger.kernel.org, ard.biesheuvel@linaro.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V2 1/2] Abstract out support for locating an EFI config
 table
Message-ID: <20190610165819.GA10114@linux.intel.com>
References: <20190607205147.102904-1-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607205147.102904-1-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 07, 2019 at 01:51:46PM -0700, Matthew Garrett wrote:
> We want to grab a pointer to the TPM final events table, so abstract out
> the existing code for finding an FDT table and make it generic.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

Just to clarify are these extensions to what you did before and not
something that needs be squashed your commits pipelined for v5.3?

/Jarkko
