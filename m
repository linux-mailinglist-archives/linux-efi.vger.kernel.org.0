Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6F11ECD21
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jun 2020 12:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFCKFQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Jun 2020 06:05:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53224 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgFCKFP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Jun 2020 06:05:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053A2MhT140203;
        Wed, 3 Jun 2020 10:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=3iilLjJ7FJeumkxGuTaUJKqfXXAc6XgeiJNXCuZflnA=;
 b=CL3AfIOz6gssVADJHJgZOHH4nArCDfpyH/G3p0ZuI25J5Xh0771BY4PVsCcucLHmB7J7
 bOJht9ThUFDpN+rTxoqz+bCUFhpZRRWukWzAEimsNBo/pBq9kkLUs1W7IrW2I1NjS2mI
 4gjtlOepA9nHvONiP/6YRorHvKJROjIMk+/c0Xz5g5+QfEpzUZmxbp+VlXa/NO5QWGwe
 q7GPVHpEw0rTm2rmBvCOBUYaiBtKOSYtDqcHbnCBT5GflcN7ecrlQXNgSMsqR+JSYtet
 zOZZ4NNsaMFt3oZl4XCDu3cYM1+qCErVoOBmUATi56h6nIx3pOveGkPrcr7YyzVo6SvZ fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31dkrungeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 10:05:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053A3SH8079608;
        Wed, 3 Jun 2020 10:05:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31c12qne3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 10:05:11 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 053A59YW001149;
        Wed, 3 Jun 2020 10:05:09 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 03:05:09 -0700
Date:   Wed, 3 Jun 2020 13:05:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     nivedita@alum.mit.edu
Cc:     linux-efi@vger.kernel.org
Subject: [bug report] efi/libstub: Unify initrd loading across architectures
Message-ID: <20200603100501.GA1843390@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=3 spamscore=0 bulkscore=0 mlxlogscore=836
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=3 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=856 cotscore=-2147483648 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030078
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Arvind Sankar,

The patch f61900fd0ebf: "efi/libstub: Unify initrd loading across
architectures" from Apr 30, 2020, leads to the following static
checker warning:

	drivers/firmware/efi/libstub/efi-stub-helper.c:481 efi_load_initrd_cmdline()
	error: we previously assumed 'image' could be null (see line 474)

drivers/firmware/efi/libstub/efi-stub-helper.c
   466  static
   467  efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
   468                                       unsigned long *load_addr,
   469                                       unsigned long *load_size,
   470                                       unsigned long soft_limit,
   471                                       unsigned long hard_limit)
   472  {
   473          if (!IS_ENABLED(CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER) ||
   474              (IS_ENABLED(CONFIG_X86) && (!efi_is_native() || image == NULL))) {
                     ^^^^^^^^^^^^^^^^^^^^^^                         ^^^^^^^^^^^^^
Assume X86 is not configured but "image" is NULL.

   475                  *load_addr = *load_size = 0;
   476                  return EFI_SUCCESS;
   477          }
   478  
   479          return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
                                            ^^^^^
Dereferenced inside the function.

   480                                      soft_limit, hard_limit,
   481                                      load_addr, load_size);
   482  }

regards,
dan carpenter
