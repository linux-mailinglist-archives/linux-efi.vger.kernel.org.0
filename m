Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A575711EA10
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 19:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfLMSQl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 13:16:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49236 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728784AbfLMSQl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 13 Dec 2019 13:16:41 -0500
Received: from zn.tnic (p200300EC2F0A5A00F0A2BADA183BEA41.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:f0a2:bada:183b:ea41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 590A91EC0D0E;
        Fri, 13 Dec 2019 19:16:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576260999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pQrlGebVtQdUG0Cu8fh4rdDJnYScv2XeFoXbzttbuWI=;
        b=Xk41lKxfwsJ9iMbjooMDUi5YTAIRyTqoEsh19Rud34sWM2+XzgIGWcUUkfz7yPLJmOQ03u
        Cu9CZUGtNziiIPpzhCUS4njUOKKzgiLxtTx32l89wELjBdvCGWg5U0vFGbbIMhAc6YWnYN
        9EFq/QWkbBv2ljtgtxwwKfB/I9Zm3Ao=
Date:   Fri, 13 Dec 2019 19:16:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-efi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        james.morse@arm.com, rjw@rjwysocki.net, tony.luck@intel.com,
        linuxarm@huawei.com, ard.biesheuvel@linaro.org,
        nariman.poushin@linaro.org,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>
Subject: Re: [PATCH v5 1/6] efi / ras: CCIX Memory error reporting
Message-ID: <20191213181633.GC25899@zn.tnic>
References: <20191114133919.32290-1-Jonathan.Cameron@huawei.com>
 <20191114133919.32290-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191114133919.32290-2-Jonathan.Cameron@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 14, 2019 at 09:39:14PM +0800, Jonathan Cameron wrote:
> CCIX defines a number of different error types
> (See CCIX spec 1.0) and UEFI 2.8 defines a CPER record to allow
> for them to be reported when firmware first handling is in use.
> The last part of that record is a copy of the CCIX protocol
> error record which can provide very detailed information.
> 
> This patch introduces infrastructure and support for one of those
> error types, CCIX Memory Errors.  Later patches will supply
> equivalent support for the other error types.
> 
> The variable length and content of the different messages makes
> a single tracepoint impractical.  As such the RAS tracepoint introduced
> in this patch only covers the memory error. Additional trace points
> will be introduced for other error types along with their
> cper handling in the rest of this series.
> 
> Updated RAS daemon support to be posted shortly.
> qemu injection patches also available but not currently planing
> to upstream those.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> 
> Changes since v4
> * Fixed length array parameters
> * Take advantage of being first print to string and simplify code.
> * Fix buffer overflow risk in snprintf calls.
> 
>  drivers/acpi/apei/Kconfig        |   8 +
>  drivers/acpi/apei/ghes.c         |  39 ++++
>  drivers/firmware/efi/Kconfig     |   5 +
>  drivers/firmware/efi/Makefile    |   1 +
>  drivers/firmware/efi/cper-ccix.c | 362 +++++++++++++++++++++++++++++++
>  drivers/firmware/efi/cper.c      |   6 +
>  include/linux/cper.h             | 118 ++++++++++
>  include/ras/ras_event.h          |  79 +++++++
>  8 files changed, 618 insertions(+)
> 
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index 6b18f8bc7be3..e687b18dee34 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -68,3 +68,11 @@ config ACPI_APEI_ERST_DEBUG
>  	  error information to and from a persistent store. Enable this
>  	  if you want to debugging and testing the ERST kernel support
>  	  and firmware implementation.
> +
> +config ACPI_APEI_CCIX
> +       bool "APEI CCIX error recovery support"
> +       depends on ACPI_APEI && MEMORY_FAILURE
> +       help
> +	 CCIX has a number of defined error types. This option enables

Write out that "CCIX" acronym at least in the help here. I had to go
visit wikipedia to find out what it is.

> +	 the handling of CPER records generated by a firmware performing
> +	 firmware first error handling of these CCIX errors.
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 777f6f7122b4..75a177ae9de3 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -490,6 +490,42 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>  #endif
>  }
>  
> +static void ghes_handle_ccix_per(struct acpi_hest_generic_data *gdata, int sev)
> +{
> +#ifdef CONFIG_ACPI_APEI_CCIX
> +	struct cper_sec_ccix_header *header = acpi_hest_get_payload(gdata);
> +	__u32 *dw;
> +	enum ccix_per_type per_type;
> +	static u32 err_seq;
> +	void *payload;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

and check that for all your functions.

> +	/* Check if space for CCIX CPER header and 8 DW of a PER log header */
> +	if (gdata->error_data_length <
> +	    sizeof(*header) + CCIX_PER_LOG_HEADER_DWS * sizeof(__u32))

Put that size in a local variable so that the if-statement is more readable.

> +		return;
> +
> +	if ((header->validation_bits & CPER_CCIX_VALID_PER_LOG) == 0)

	if (!( ...

> +		return;
> +
> +	dw = (__u32 *)(header + 1);
> +
> +	per_type = FIELD_GET(CCIX_PER_LOG_DW1_PER_TYPE_M, dw[1]);
> +	payload = acpi_hest_get_payload(gdata);
> +
> +	switch (per_type) {
> +	case CCIX_MEMORY_ERROR:
> +		trace_ccix_memory_error_event(payload, err_seq, sev,
> +					      ccix_mem_err_ven_len_get(payload));
> +		break;
> +	default:
> +		/* Unknown error type */
> +		pr_info("CCIX error of unknown or vendor defined type\n");
> +		break;
> +	}
> +	err_seq++;
> +#endif
> +}
> +
>  static void ghes_do_proc(struct ghes *ghes,
>  			 const struct acpi_hest_generic_status *estatus)
>  {
> @@ -520,6 +556,9 @@ static void ghes_do_proc(struct ghes *ghes,
>  		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>  			ghes_handle_aer(gdata);
>  		}
> +		else if (guid_equal(sec_type, &CPER_SEC_CCIX)) {
> +			ghes_handle_ccix_per(gdata, estatus->error_severity);
> +		}
>  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>  			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>  
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index b248870a9806..096e693a9522 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -209,6 +209,11 @@ config UEFI_CPER_X86
>  	depends on UEFI_CPER && X86
>  	default y
>  
> +config UEFI_CPER_CCIX
> +       bool
> +       depends on UEFI_CPER
> +       default y

Err, this whole CCIX gunk will get built on all systems now which
wanna enable UEFI_CPER but how many of those do *actually* have those
accelerators and use CCIX?

If not the majority, then this needs to be user-configurable so that
most people who don't have it, do not have to enable it and bloat their
kernels unnecessarily.

And all that code should be surrounded with ifdefs so that it is not
even there on the majority of the systems.

...

> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index 36c5c5e38c1d..560e55958561 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -14,6 +14,7 @@
>  #include <linux/cper.h>
>  #include <linux/mm.h>
>  
> +#include <linux/bitfield.h>
>  /*
>   * MCE Extended Error Log trace event
>   *
> @@ -338,6 +339,84 @@ TRACE_EVENT(aer_event,
>  			"Not available")
>  );
>  
> +#if defined(CONFIG_ACPI_APEI_CCIX)

#ifdef doesn't work here?

> +/*
> + * CCIX PER log memory error trace event
> + *
> + * These events are generated when hardware detects a corrected or
> + * uncorrected event.
> + *
> + * Some elements of the record are not included
> + * - PER version (tracepoint should remain compatible across versions)
> + * - Multiple Error
> + */
> +TRACE_EVENT(ccix_memory_error_event,
> +	TP_PROTO(struct cper_ccix_mem_error *mem,
> +		 u32 err_seq,
> +		 u8 sev,
> +		 u16 ven_len),

In any case, you have a lot of duplication between all those tracepoints
and I'm wondering why can't you have a *single* TRACE_EVENT() definition
which can deal with all the possible CCIX events?

Or have a TRACE_EVENT_CLASS()?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
