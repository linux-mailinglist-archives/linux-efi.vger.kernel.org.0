Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4287E7E04A3
	for <lists+linux-efi@lfdr.de>; Fri,  3 Nov 2023 15:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjKCO2E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Nov 2023 10:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjKCO2D (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Nov 2023 10:28:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D48D42;
        Fri,  3 Nov 2023 07:28:00 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SMNNk2h3Mz6K8YV;
        Fri,  3 Nov 2023 22:27:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 14:27:57 +0000
Date:   Fri, 3 Nov 2023 14:27:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <shiju.jose@huawei.com>
Subject: Re: [PATCH RFC v3 1/6] cxl/trace: Remove uuid from event trace
 known events
Message-ID: <20231103142756.00000e20@Huawei.com>
In-Reply-To: <20230601-cxl-cper-v3-1-0189d61f7956@intel.com>
References: <20230601-cxl-cper-v3-0-0189d61f7956@intel.com>
        <20230601-cxl-cper-v3-1-0189d61f7956@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 01 Nov 2023 14:11:18 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> The uuid printed in the well known events is redundant.  The uuid
> defines what the event was.
> 
> Remove the uuid from the known events and only report it in the generic
> event as it remains informative there.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Removing the print is fine, but look like this also removes the actual trace point
field.  That's userspace ABI.  Expanding it is fine, but taking fields away
is more problematic.

Are we sure we don't break anyone?  Shiju, will rasdaemon be fine with this
change?

Thanks,

Jonathan



> ---
>  drivers/cxl/core/trace.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index a0b5819bc70b..79ed03637604 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -189,7 +189,6 @@ TRACE_EVENT(cxl_overflow,
>  	__string(memdev, dev_name(&cxlmd->dev))			\
>  	__string(host, dev_name(cxlmd->dev.parent))		\
>  	__field(int, log)					\
> -	__field_struct(uuid_t, hdr_uuid)			\
>  	__field(u64, serial)					\
>  	__field(u32, hdr_flags)					\
>  	__field(u16, hdr_handle)				\
> @@ -203,7 +202,6 @@ TRACE_EVENT(cxl_overflow,
>  	__assign_str(host, dev_name((cxlmd)->dev.parent));			\
>  	__entry->log = (l);							\
>  	__entry->serial = (cxlmd)->cxlds->serial;				\
> -	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
>  	__entry->hdr_length = (hdr).length;					\
>  	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
>  	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> @@ -212,12 +210,12 @@ TRACE_EVENT(cxl_overflow,
>  	__entry->hdr_maint_op_class = (hdr).maint_op_class
>  
>  #define CXL_EVT_TP_printk(fmt, ...) \
> -	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
> +	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu "		\
>  		"len=%d flags='%s' handle=%x related_handle=%x "		\
>  		"maint_op_class=%u : " fmt,					\
>  		__get_str(memdev), __get_str(host), __entry->serial,		\
>  		cxl_event_log_type_str(__entry->log),				\
> -		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
> +		__entry->hdr_timestamp, __entry->hdr_length,			\
>  		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
>  		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
>  		##__VA_ARGS__)
> @@ -231,15 +229,17 @@ TRACE_EVENT(cxl_generic_event,
>  
>  	TP_STRUCT__entry(
>  		CXL_EVT_TP_entry
> +		__field_struct(uuid_t, hdr_uuid)
>  		__array(u8, data, CXL_EVENT_RECORD_DATA_LENGTH)
>  	),
>  
>  	TP_fast_assign(
>  		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> +		memcpy(&__entry->hdr_uuid, &rec->hdr.id, sizeof(uuid_t));
>  		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
>  	),
>  
> -	CXL_EVT_TP_printk("%s",
> +	CXL_EVT_TP_printk("uuid=%pUb %s", &__entry->hdr_uuid,
>  		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
>  );
>  
> 

