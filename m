Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87BAF18D108
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 15:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgCTOgS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Mar 2020 10:36:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51192 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgCTOgS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Mar 2020 10:36:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KEABLR153355;
        Fri, 20 Mar 2020 14:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=orcSXTvzl+Xu3zdH1yJK4rv6NFxMx65lBs568wzS5cc=;
 b=L1ws6ajqJmerUTtgHKCsRAAz6Ed5ByQzYW62x2XEOxwWRTAJSSt6dsOon4aBaxv1uqXB
 uZtW1a7TGTEXgTjFsu3BYBzq8ifMVaWyXi0AEaCZv6ahn9Zv+JQIM0TAJ9wRWmrcSGC8
 esx220mjmLD8uPn40KQhaYMtzE1tMRAB2xanb6KATyllv1vH2CKwBUQSVmh/GwroPLbM
 y0d532BuyRGp5zbCaxNL4wWFDxaP8rRkDFLOpSks1gjUysIGlVUEWdpK4HVqomRACEbF
 CU0ly/JUrha3EQrfpPgwcsDHS9W12UXreuinXPjLu5bKLETgJ4Fban4LKHdQGsYZrofp MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2yub27dvab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 14:36:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KEJrXN193827;
        Fri, 20 Mar 2020 14:36:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2ys92qnrj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 14:36:12 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02KEaBtj022504;
        Fri, 20 Mar 2020 14:36:11 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Mar 2020 07:36:10 -0700
Date:   Fri, 20 Mar 2020 17:36:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Arvind Sankar <nivedita@alum.mit.edu>
Cc:     kbuild-all@lists.01.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] efi/gop: Allow specifying mode number on command
 line
Message-ID: <20200320143526.GI4650@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319192855.29876-12-nivedita@alum.mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200059
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Arvind,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Arvind-Sankar/efi-gop-Refactoring-mode-setting-feature/20200320-044605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/firmware/efi/libstub/gop.c:113 set_mode() error: uninitialized symbol 'new_mode'.

# https://github.com/0day-ci/linux/commit/af85e496c9f577df9743784171b1cda94220dd8f
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout af85e496c9f577df9743784171b1cda94220dd8f
vim +/info +85 drivers/firmware/efi/libstub/gop.c

af85e496c9f577 Arvind Sankar 2020-03-19   97  static void set_mode(efi_graphics_output_protocol_t *gop)
af85e496c9f577 Arvind Sankar 2020-03-19   98  {
af85e496c9f577 Arvind Sankar 2020-03-19   99  	efi_graphics_output_protocol_mode_t *mode;
af85e496c9f577 Arvind Sankar 2020-03-19  100  	u32 cur_mode, new_mode;
af85e496c9f577 Arvind Sankar 2020-03-19  101  
af85e496c9f577 Arvind Sankar 2020-03-19  102  	switch (cmdline.option) {
af85e496c9f577 Arvind Sankar 2020-03-19  103  	case EFI_CMDLINE_NONE:
af85e496c9f577 Arvind Sankar 2020-03-19  104  		return;
af85e496c9f577 Arvind Sankar 2020-03-19  105  	case EFI_CMDLINE_MODE_NUM:
af85e496c9f577 Arvind Sankar 2020-03-19  106  		new_mode = choose_mode_modenum(gop);
af85e496c9f577 Arvind Sankar 2020-03-19  107  		break;

No default case?

af85e496c9f577 Arvind Sankar 2020-03-19  108  	}
af85e496c9f577 Arvind Sankar 2020-03-19  109  
af85e496c9f577 Arvind Sankar 2020-03-19  110  	mode = efi_table_attr(gop, mode);
af85e496c9f577 Arvind Sankar 2020-03-19  111  	cur_mode = efi_table_attr(mode, mode);
af85e496c9f577 Arvind Sankar 2020-03-19  112  
af85e496c9f577 Arvind Sankar 2020-03-19 @113  	if (new_mode == cur_mode)
af85e496c9f577 Arvind Sankar 2020-03-19  114  		return;
af85e496c9f577 Arvind Sankar 2020-03-19  115  
af85e496c9f577 Arvind Sankar 2020-03-19  116  	if (efi_call_proto(gop, set_mode, new_mode) != EFI_SUCCESS)
af85e496c9f577 Arvind Sankar 2020-03-19  117  		efi_printk("Failed to set requested mode\n");
af85e496c9f577 Arvind Sankar 2020-03-19  118  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
