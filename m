Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC62635F4E
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2019 16:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfFEOcY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jun 2019 10:32:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:35243 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbfFEOcX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 5 Jun 2019 10:32:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 07:32:22 -0700
X-ExtLoop1: 1
Received: from araresx-wtg1.ger.corp.intel.com (HELO localhost) ([10.252.46.102])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jun 2019 07:32:18 -0700
Date:   Wed, 5 Jun 2019 17:32:17 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Chris Coulson <chris.coulson@canonical.com>
Cc:     linux-integrity@vger.kernel.org, linux-efi@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Garrett <mjg59@google.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix crash in __calc_tpm2_event_size
Message-ID: <20190605143217.GE11331@linux.intel.com>
References: <20190604230433.20936-1-chris.coulson@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604230433.20936-1-chris.coulson@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 05, 2019 at 12:04:32AM +0100, Chris Coulson wrote:
> I've been testing the latest code in the linux-tpmdd branch and I'm
> experiencing a crash in __calc_tpm2_event_size when it's called to
> calculate the size of events in the final log. I hope I'm not stepping on
> anyone's toes, but this small change seems to fix it.

Oh no, thank you for reporting this.

/Jarkko
