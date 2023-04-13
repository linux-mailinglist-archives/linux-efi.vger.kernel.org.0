Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CAE6E11D2
	for <lists+linux-efi@lfdr.de>; Thu, 13 Apr 2023 18:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjDMQIt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Apr 2023 12:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDMQIq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Apr 2023 12:08:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B624772B3;
        Thu, 13 Apr 2023 09:08:33 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Py4Bd05W5z689N7;
        Fri, 14 Apr 2023 00:03:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Apr
 2023 17:08:17 +0100
Date:   Thu, 13 Apr 2023 17:08:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] efi/cper: Export cper_mem_err_unpack() for use
 by modules
Message-ID: <20230413170816.0000333b@Huawei.com>
In-Reply-To: <20230411180302.2678736-3-terry.bowman@amd.com>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
        <20230411180302.2678736-3-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 11 Apr 2023 13:02:58 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The CXL driver plans to use cper_print_aer() for restricted CXL host (RCH)
> logging. This is not currently possible if CXL is built as a loadable
> module because cper_print_aer() depends on cper_mem_err_unpack() which
> is not exported.
> 
> Export cper_mem_err_unpack() to enable cper_print_aer() usage in
> CXL and other loadable modules.

No problem with the export, but I'm struggling to see the path that needs it.
Could you give a little more detail, perhaps a call path?

Thanks,

Jonathan

> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> ---
>  drivers/firmware/efi/cper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 35c37f667781..ff15e12160ae 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -350,6 +350,7 @@ const char *cper_mem_err_unpack(struct trace_seq *p,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(cper_mem_err_unpack);
>  
>  static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
>  	int len)

