Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3C3BDC4E
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2019 12:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfIYKk6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Sep 2019 06:40:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:44959 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729957AbfIYKk5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Sep 2019 06:40:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 03:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,547,1559545200"; 
   d="scan'208";a="179777327"
Received: from dariusvo-mobl.ger.corp.intel.com (HELO localhost) ([10.249.39.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Sep 2019 03:40:54 -0700
Date:   Wed, 25 Sep 2019 13:40:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] tpm: only set efi_tpm_final_log_size after
 successful event log parsing
Message-ID: <20190925104050.GD6256@linux.intel.com>
References: <20190918191626.5741-1-jsnitsel@redhat.com>
 <20190923171010.csz4js3xs2mixmpq@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923171010.csz4js3xs2mixmpq@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 23, 2019 at 10:10:10AM -0700, Jerry Snitselaar wrote:
> Any thoughts on this? I know of at least 2 Lenovo models that are
> running into this problem.
> 
> In the case of the one I have currently have access to the problem is
> that the hash algorithm id for an event isn't one that is currently in
> the TCG registry, and it fails to find a match when walking the
> digest_sizes array. That seems like an issue for the vendor to fix in the bios,
> but we should look at the return value of tpm2_calc_event_log_size and not
> stick a negative value in efi_tpm_final_log_size.

Please use then "pr_err(FW_BUG".

Also, since you know the context you could add a comment along the
lines what you wrote.

/Jarkko
