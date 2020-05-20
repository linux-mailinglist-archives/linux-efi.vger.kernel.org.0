Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A351DBC19
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 19:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgETR5G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 13:57:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47022 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgETR5F (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 May 2020 13:57:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KHltod092459;
        Wed, 20 May 2020 17:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=yB+sRelD8Yf/aSv30BZHaKCU1UG7BPZ/0HtXQYWn5xs=;
 b=wyrlqKfo3S/VpYOlW0fRofmnh3EG4lJIGY0jgiuiMDclu1eHGOk85Av/OGZZBl4hPOrc
 a7uzR8I29QRtldHc9I9DFOHBoFLXLm+gtWKbvNqh75X3eQjJ5l5/eZZvWmj/OoRSu+vL
 Yk37i+Ax+G1mGnlhLMPcdjq4RJ3puqQJOyFC9JIipHwN8fBLvSewOwOLgpdQE6ArWHkY
 G64DX31tjSl7aB/5PIIzOGnxHhe34GOQg/aK08VrW8Wou1KTgo2ukAfxJ0FhfbOEtWi7
 LhLbj4Q9t9ZxglU5owCOzzNrzjuXmMVd+5uzWBFvTexgpTYxFyL71I1i8Q5y6uenzPq7 rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31284m4jaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 17:56:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KHrCY9176547;
        Wed, 20 May 2020 17:54:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 315020pkte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 17:54:57 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04KHsuWZ015729;
        Wed, 20 May 2020 17:54:56 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 10:54:55 -0700
Date:   Wed, 20 May 2020 20:54:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [efi:next 39/40]
 drivers/firmware/efi/libstub/efi-stub-helper.c:265 efi_convert_cmdline()
 warn: qualifier 'l' ignored for %s specifier
Message-ID: <20200520175449.GR3041@kadam>
References: <20200520140903.GA30374@kadam>
 <20200520154308.GA3184088@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520154308.GA3184088@rani.riverdale.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005200144
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 20, 2020 at 11:43:08AM -0400, Arvind Sankar wrote:
> On Wed, May 20, 2020 at 05:09:03PM +0300, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> > head:   e5fbadd1179cdadeaa44d71a9ec068c5bc100524
> > commit: 85f5afd4322d294a7eca0d304744a1646113fbd9 [39/40] efi/libstub: Use snprintf with %ls to convert the command line
> > config: x86_64-defconfig (attached as .config)
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > New smatch warnings:
> > drivers/firmware/efi/libstub/efi-stub-helper.c:265 efi_convert_cmdline() warn: qualifier 'l' ignored for %s specifier
> > 
> > # https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=85f5afd4322d294a7eca0d304744a1646113fbd9
> > git remote add efi https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
> > git remote update efi
> > git checkout 85f5afd4322d294a7eca0d304744a1646113fbd9
> > vim +/l +265 drivers/firmware/efi/libstub/efi-stub-helper.c
> > 
> > c625d1c203941f drivers/firmware/efi/efi-stub-helper.c         H. Peter Anvin 2013-09-20  258  	options_bytes++;	/* NUL termination */
> > 9403e462fb5ffa drivers/firmware/efi/efi-stub-helper.c         Leif Lindholm  2014-04-04  259  
> > 1e45bf7372c48c drivers/firmware/efi/libstub/efi-stub-helper.c Ard Biesheuvel 2020-02-10  260  	status = efi_allocate_pages(options_bytes, &cmdline_addr, max_addr);
> > 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  261  	if (status != EFI_SUCCESS)
> > 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  262  		return NULL;
> > 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  263  
> > 85f5afd4322d29 drivers/firmware/efi/libstub/efi-stub-helper.c Arvind Sankar  2020-05-18  264  	snprintf((char *)cmdline_addr, options_bytes, "%.*ls",
> >                                                                                                                                                   ^
> > The "l" doesn't make sense here?
> 
> The previous patches add support for wide strings to the version of
> snprintf used here.

Ah.  Thanks.  I will update the Smatch check.

regards,
dan carpenter

