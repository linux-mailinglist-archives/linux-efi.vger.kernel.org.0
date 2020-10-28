Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D5B29D7C4
	for <lists+linux-efi@lfdr.de>; Wed, 28 Oct 2020 23:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbgJ1W0u (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 28 Oct 2020 18:26:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54176 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733111AbgJ1W0t (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 28 Oct 2020 18:26:49 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id CD3D020B9C34;
        Wed, 28 Oct 2020 10:40:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD3D020B9C34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603906808;
        bh=9V/wA3eXya9REkla/z2rwncx5LLcdFmF/Ap1Ekj0sjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NflQEIxO3XBHmrmUqH90zd3OayoD/Scy0UPhkh0+nac9jaT38VztFcWZ5eqfaOa95
         EaZtVM4a2uGCtavOI2YM1PfSZZEnYBWY0HmRbmIQ0sUHefFo2WPrgG23zxrgZj7Gbq
         oLyXB3CYM3c91nbIPdZuoeXvoR5vpxAb2JvbtRp4=
Date:   Wed, 28 Oct 2020 12:39:58 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org,
        =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] tpm: efi: Don't create binary_bios_measurements file for
 an empty log
Message-ID: <20201028173958.GA4624@sequoia>
References: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com>
 <20201028154102.9595-1-tyhicks@linux.microsoft.com>
 <20201028163002.GA5150@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028163002.GA5150@sequoia>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2020-10-28 11:30:11, Tyler Hicks wrote:
> So, we need help from Kai, Kenneth, or Mimi to verify my assumption that
> their firmware is providing an empty main event log and a populated
> final event log.

Hi Kai, Kenneth, and Mimi - could one or two of you please follow these
steps:

1) Apply the proposed patch in the grandparent of this email so that
   your kernel doesn't crash
2) Revert commit 7f3d176f5f7e ("tpm: Require that all digests are
   present in TCG_PCR_EVENT2 structures") so that
   __calc_tpm2_event_size() goes back to being less picky and may treat
   a final log event as a valid event log header
3) Add some debugging warnings in efi_tpm_eventlog_init() to check for
   an empty main event log and a populated final event log, as shown
   below
4) Boot the resulting kernel build, look for the warnings, and report
   back

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index c1955d320fec..c4d2dbd5ed42 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -78,6 +78,9 @@ int __init efi_tpm_eventlog_init(void)
 		goto out;
 	}
 
+	WARN(!log_tbl->size && final_tbl->nr_events,
+	     "nr_events = %llu\n", final_tbl->nr_events);
+
 	tbl_size = 0;
 	if (final_tbl->nr_events != 0) {
 		void *events = (void *)efi.tpm_final_log
@@ -95,6 +98,8 @@ int __init efi_tpm_eventlog_init(void)
 		goto out_calc;
 	}
 
+	WARN(!log_tbl->size && tbl_size, "tbl_size = %d\n", tbl_size);
+
 	memblock_reserve((unsigned long)final_tbl,
 			 tbl_size + sizeof(*final_tbl));
 	efi_tpm_final_log_size = tbl_size;

For your convenience, I've created a branch with these changes on top of
v5.9:

 https://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/linux.git/log/?h=tpm/bin-bios-measurements-debug

Thank you!

Tyler
