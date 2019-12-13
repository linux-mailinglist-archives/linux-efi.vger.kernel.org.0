Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8591411E5DE
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 15:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfLMOx2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 09:53:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfLMOx2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 09:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O1lTvrez9BfqDz6dWwHlTUzsfr1CMMJPuBwlVLCUrpY=; b=XsQHpqQxQW2ILsutxdZLcnLSd
        4cwnd5sfVKneDo57XKkndHcoVvjgr5bXbE6DcQJwPDJa6SFQLWWLNquwix487jz+PLq8k9oVoQcdG
        Y07wnkcg2NoplPDDHTqN6wV4qXFphxKY2a/DcHXZePae515KrKNoMn71LhO0igmDvltjHV5DjfWYa
        lZc2RuHKhjzmrC4aokHRVTCLBsIprju5IkT4JG8yXn1dWlfHxx4zuIQKaF04zB2ChAdltZ0HfHDc/
        31xtUTGufuHePLzdEUNxYVCFhmgWLWWVhlIthQ2IAu2Js4Kj/ZnirY72kYIyjb+RQl1IjWRLNsBfm
        cC8nZmQKQ==;
Received: from tmo-101-54.customers.d1-online.com ([80.187.101.54] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifmJr-00008e-JE; Fri, 13 Dec 2019 14:53:28 +0000
Date:   Fri, 13 Dec 2019 15:53:22 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        <james.morse@arm.com>, <rjw@rjwysocki.net>, <tony.luck@intel.com>,
        <linuxarm@huawei.com>, <ard.biesheuvel@linaro.org>,
        <nariman.poushin@linaro.org>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>
Subject: Re: [PATCH v5 6/6] efi / ras: CCIX Agent internal error reporting
Message-ID: <20191213155322.2f169ed0@kernel.org>
In-Reply-To: <20191114133919.32290-7-Jonathan.Cameron@huawei.com>
References: <20191114133919.32290-1-Jonathan.Cameron@huawei.com>
        <20191114133919.32290-7-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Em Thu, 14 Nov 2019 21:39:19 +0800
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> The CCIX 1.0 Base specification defines an internal agent error,
> for which the specific data present afte the header is vendor
> defined.
> 

Patches 3 to 6 just repeats the same things I mentioned already on
patch 1.

Except for that, the series look ready for merging on my PoV.

Regards,
Mauro

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> Changes since v4
> * none
> 
>  drivers/acpi/apei/ghes.c         |  4 ++
>  drivers/firmware/efi/cper-ccix.c | 43 +++++++++++++++++++++
>  include/linux/cper.h             | 29 +++++++++++++++
>  include/ras/ras_event.h          | 64 ++++++++++++++++++++++++++++++++
>  4 files changed, 140 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 22df8c14ec13..5a75fb0374dd 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -533,6 +533,10 @@ static void ghes_handle_ccix_per(struct acpi_hest_generic_data *gdata, int sev)
>  		trace_ccix_link_error_event(payload, err_seq, sev,
>  					    ccix_link_err_ven_len_get(payload));
>  		break;
> +	case CCIX_AGENT_INTERNAL_ERROR:
> +		trace_ccix_agent_error_event(payload, err_seq, sev,
> +					     ccix_agent_err_ven_len_get(payload));
> +		break;
>  	default:
>  		/* Unknown error type */
>  		pr_info("CCIX error of unknown or vendor defined type\n");
> diff --git a/drivers/firmware/efi/cper-ccix.c b/drivers/firmware/efi/cper-ccix.c
> index ea17fb9140f9..d95fddf17bd3 100644
> --- a/drivers/firmware/efi/cper-ccix.c
> +++ b/drivers/firmware/efi/cper-ccix.c
> @@ -587,6 +587,38 @@ static int cper_ccix_link_err_details(const char *pfx,
>  	return 0;
>  }
>  
> +static int cper_ccix_agent_err_details(const char *pfx,
> +				       struct acpi_hest_generic_data *gdata)
> +{
> +	struct cper_ccix_agent_err *full_agent_err;
> +	struct cper_sec_ccix_agent_err *agent_err;
> +	u16 vendor_data_len;
> +	int i;
> +
> +	if (gdata->error_data_length < sizeof(*full_agent_err))
> +		return -ENOSPC;
> +
> +	full_agent_err = acpi_hest_get_payload(gdata);
> +
> +	agent_err = &full_agent_err->agent_record;
> +
> +	if (agent_err->validation_bits & CCIX_AGENT_INTERNAL_ERR_VENDOR_DATA_VALID) {
> +		if (gdata->error_data_length < sizeof(*full_agent_err) + 4)
> +			return -ENOSPC;
> +
> +		vendor_data_len = agent_err->vendor_data[0] & GENMASK(15, 0);
> +		if (gdata->error_data_length <
> +		    sizeof(*full_agent_err) + vendor_data_len)
> +			return -ENOSPC;
> +
> +		for (i = 0; i < vendor_data_len/4 - 1; i++)
> +			printk("%s""Vendor%d: 0x%08x\n", pfx, i,
> +			       agent_err->vendor_data[i + 1]);
> +	}
> +
> +	return 0;
> +}
> +
>  int cper_print_ccix_per(const char *pfx, struct acpi_hest_generic_data *gdata)
>  {
>  	struct cper_sec_ccix_header *header = acpi_hest_get_payload(gdata);
> @@ -656,6 +688,8 @@ int cper_print_ccix_per(const char *pfx, struct acpi_hest_generic_data *gdata)
>  		return cper_ccix_port_err_details(pfx, gdata);
>  	case CCIX_LINK_ERROR:
>  		return cper_ccix_link_err_details(pfx, gdata);
> +	case CCIX_AGENT_INTERNAL_ERROR:
> +		return cper_ccix_agent_err_details(pfx, gdata);
>  	default:
>  		/* Vendor defined so no formatting be done */
>  		break;
> @@ -878,3 +912,12 @@ const char *cper_ccix_link_err_unpack(struct trace_seq *p,
>  
>  	return ret;
>  }
> +
> +void cper_ccix_agent_err_pack(const struct cper_sec_ccix_agent_err *agent_record,
> +			      struct cper_ccix_agent_err_compact *cagent_err,
> +			      const u16 vendor_data_len,
> +			      u8 *vendor_data)
> +{
> +	cagent_err->validation_bits = agent_record->validation_bits;
> +	memcpy(vendor_data, &agent_record->vendor_data[1], vendor_data_len);
> +}
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index d35be55351e3..373c1d387a70 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -783,6 +783,30 @@ struct cper_ccix_link_err_compact {
>  	__u8	credit_type;
>  };
>  
> +struct cper_sec_ccix_agent_err {
> +	__u32	validation_bits;
> +#define CCIX_AGENT_INTERNAL_ERR_VENDOR_DATA_VALID	BIT(0)
> +	__u32	vendor_data[];
> +};
> +
> +struct cper_ccix_agent_err {
> +	struct cper_sec_ccix_header header;
> +	__u32 ccix_header[CCIX_PER_LOG_HEADER_DWS];
> +	struct cper_sec_ccix_agent_err agent_record;
> +};
> +
> +static inline u16 ccix_agent_err_ven_len_get(struct cper_ccix_agent_err *agent_err)
> +{
> +	if (agent_err->agent_record.validation_bits & CCIX_AGENT_INTERNAL_ERR_VENDOR_DATA_VALID)
> +		return agent_err->agent_record.vendor_data[0] & 0xFFFF;
> +	else
> +		return 0;
> +}
> +
> +struct cper_ccix_agent_err_compact {
> +	__u32	validation_bits;
> +};
> +
>  /* Reset to default packing */
>  #pragma pack()
>  
> @@ -835,6 +859,11 @@ void cper_ccix_link_err_pack(const struct cper_sec_ccix_link_error *link_record,
>  const char *cper_ccix_link_err_unpack(struct trace_seq *p,
>  				      struct cper_ccix_link_err_compact *clink_err);
>  
> +void cper_ccix_agent_err_pack(const struct cper_sec_ccix_agent_err *agent_record,
> +			      struct cper_ccix_agent_err_compact *cagent_err,
> +			      const u16 vendor_data_len,
> +			      u8 *vendor_data);
> +
>  struct acpi_hest_generic_data;
>  int cper_print_ccix_per(const char *pfx,
>  			struct acpi_hest_generic_data *gdata);
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index 7cecfadb0b15..59b62d5cd8cf 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -679,6 +679,70 @@ TRACE_EVENT(ccix_link_error_event,
>  		__print_hex(__get_dynamic_array(vendor_data), __entry->vendor_data_length)
>  	)
>  );
> +
> +TRACE_EVENT(ccix_agent_error_event,
> +	TP_PROTO(struct cper_ccix_agent_err *err,
> +		 u32 err_seq,
> +		 u8 sev, u16 ven_len),
> +
> +	TP_ARGS(err, err_seq, sev, ven_len),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, err_seq)
> +		__field(u8, sev)
> +		__field(u8, sevdetail)
> +		__field(u8, source)
> +		__field(u8, component)
> +		__field(u64, pa)
> +		__field(u8, pa_mask_lsb)
> +		__field(u16, vendor_data_length)
> +		__field_struct(struct cper_ccix_agent_err_compact, data)
> +		__dynamic_array(u8, vendor_data, ven_len)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->err_seq = err_seq;
> +
> +		__entry->sev = sev;
> +		__entry->sevdetail = FIELD_GET(CCIX_PER_LOG_DW1_SEV_UE_M |
> +			CCIX_PER_LOG_DW1_SEV_NO_COMM_M |
> +			CCIX_PER_LOG_DW1_SEV_DEGRADED_M |
> +			CCIX_PER_LOG_DW1_SEV_DEFFERABLE_M,
> +			err->ccix_header[1]);
> +		if (err->header.validation_bits & 0x1)
> +			__entry->source = err->header.source_id;
> +		else
> +			__entry->source = ~0;
> +		__entry->component = FIELD_GET(CCIX_PER_LOG_DW1_COMP_TYPE_M,
> +						   err->ccix_header[1]);
> +		if (err->ccix_header[1] & CCIX_PER_LOG_DW1_ADDR_VAL_M) {
> +			__entry->pa = (u64)err->ccix_header[2] << 32 |
> +				(err->ccix_header[3] & 0xfffffffc);
> +			__entry->pa_mask_lsb = err->ccix_header[4] & 0xff;
> +		} else {
> +			__entry->pa = ~0ull;
> +			__entry->pa_mask_lsb = ~0;
> +		}
> +		/* Do not store the vendor data header length */
> +		__entry->vendor_data_length = ven_len ? ven_len - 4 : 0;
> +		cper_ccix_agent_err_pack(&err->agent_record, &__entry->data,
> +					__entry->vendor_data_length,
> +					__get_dynamic_array(vendor_data));
> +	),
> +
> +	TP_printk("{%d} %s CCIX PER Agent Internal Error in %s SevUE:%d SevNoComm:%d SevDegraded:%d SevDeferred:%d physical addr: %016llx (mask: %x) vendor:%s",
> +		__entry->err_seq,
> +		cper_severity_str(__entry->sev),
> +		cper_ccix_comp_type_str(__entry->component),
> +		__entry->sevdetail & BIT(0) ? 1 : 0,
> +		__entry->sevdetail & BIT(1) ? 1 : 0,
> +		__entry->sevdetail & BIT(2) ? 1 : 0,
> +		__entry->sevdetail & BIT(3) ? 1 : 0,
> +		__entry->pa,
> +		__entry->pa_mask_lsb,
> +		__print_hex(__get_dynamic_array(vendor_data), __entry->vendor_data_length)
> +	)
> +);
>  #endif
>  
>  /*




Cheers,
Mauro
