Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE376E228B
	for <lists+linux-efi@lfdr.de>; Fri, 14 Apr 2023 13:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjDNLsN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Apr 2023 07:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDNLsM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Apr 2023 07:48:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B0483ED;
        Fri, 14 Apr 2023 04:48:09 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PyZQB6156z6JCL5;
        Fri, 14 Apr 2023 19:45:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 14 Apr
 2023 12:48:07 +0100
Date:   Fri, 14 Apr 2023 12:48:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <Terry.Bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] efi/cper: Export cper_mem_err_unpack() for use
 by modules
Message-ID: <20230414124805.00000479@Huawei.com>
In-Reply-To: <9d66afdb-40bd-4254-547e-05f6481dd550@amd.com>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
        <20230411180302.2678736-3-terry.bowman@amd.com>
        <20230413170816.0000333b@Huawei.com>
        <9d66afdb-40bd-4254-547e-05f6481dd550@amd.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 13 Apr 2023 14:40:10 -0500
Terry Bowman <Terry.Bowman@amd.com> wrote:

> Hi Jonathan,
> 
> On 4/13/23 11:08, Jonathan Cameron wrote:
> > On Tue, 11 Apr 2023 13:02:58 -0500
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >   
> >> The CXL driver plans to use cper_print_aer() for restricted CXL host (RCH)
> >> logging. This is not currently possible if CXL is built as a loadable
> >> module because cper_print_aer() depends on cper_mem_err_unpack() which
> >> is not exported.
> >>
> >> Export cper_mem_err_unpack() to enable cper_print_aer() usage in
> >> CXL and other loadable modules.  
> > 
> > No problem with the export, but I'm struggling to see the path that needs it.
> > Could you give a little more detail, perhaps a call path?
> >   
> 
> The cper_print_aer() is used to log RCH dport AER errors. This is needed 
> because the RCH dport AER errors are not handled directly by the AER port 
> driver. I'll add these details to the patch.

Ah. I wasn't particularly clear.  cper_print_aer() is fine, but oddly
I'm not seeing where that results in a call to cper_mem_err_unpack()

More than possible my grep skills are failing me!

Jonathan

> 
> Regards,
> Terry
> 
> > Thanks,
> > 
> > Jonathan
> >   
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> Cc: Ard Biesheuvel <ardb@kernel.org>
> >> Cc: linux-efi@vger.kernel.org
> >> ---
> >>  drivers/firmware/efi/cper.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> >> index 35c37f667781..ff15e12160ae 100644
> >> --- a/drivers/firmware/efi/cper.c
> >> +++ b/drivers/firmware/efi/cper.c
> >> @@ -350,6 +350,7 @@ const char *cper_mem_err_unpack(struct trace_seq *p,
> >>  
> >>  	return ret;
> >>  }
> >> +EXPORT_SYMBOL_GPL(cper_mem_err_unpack);
> >>  
> >>  static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
> >>  	int len)  
> >   

