Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 820429D404
	for <lists+linux-efi@lfdr.de>; Mon, 26 Aug 2019 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732841AbfHZQa3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Aug 2019 12:30:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:55184 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729951AbfHZQa3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 26 Aug 2019 12:30:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 09:30:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="185008288"
Received: from clevorn-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.202])
  by orsmga006.jf.intel.com with ESMTP; 26 Aug 2019 09:30:22 -0700
Date:   Mon, 26 Aug 2019 19:30:20 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Peter Jones <pjones@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Matthew Garrett <mjg59@google.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Lyude Paul <lyude@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] efi+tpm: don't traverse an event log with no events
Message-ID: <20190826163020.e7sahr3irqwwneey@linux.intel.com>
References: <20190826153028.32639-1-pjones@redhat.com>
 <20190826153028.32639-2-pjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826153028.32639-2-pjones@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 26, 2019 at 11:30:28AM -0400, Peter Jones wrote:
> When there are no entries to put into the final event log, some machines
> will return the template they would have populated anyway.  In this case
> the nr_events field is 0, but the rest of the log is just garbage.
> 
> This patch stops us from trying to iterate the table with
> __calc_tpm2_event_size() when the number of events in the table is 0.
> 
> Signed-off-by: Peter Jones <pjones@redhat.com>
> Tested-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/firmware/efi/tpm.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 1d3f5ca3eaa..be51ed17c6e 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -75,11 +75,15 @@ int __init efi_tpm_eventlog_init(void)
>  		goto out;
>  	}
>  
> -	tbl_size = tpm2_calc_event_log_size((void *)efi.tpm_final_log
> -					    + sizeof(final_tbl->version)
> -					    + sizeof(final_tbl->nr_events),
> -					    final_tbl->nr_events,
> -					    log_tbl->log);
> +	tbl_size = 0;
> +	if (final_tbl->nr_events != 0) {
> +		void *events = (void *)efi.tpm_final_log
> +				+ sizeof(final_tbl->version)
> +				+ sizeof(final_tbl->nr_events);
> +		tbl_size = tpm2_calc_event_log_size(events,
> +						    final_tbl->nr_events,
> +						    log_tbl->log);
> +	}

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
