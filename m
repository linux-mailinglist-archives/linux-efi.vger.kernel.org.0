Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88D2EE37A
	for <lists+linux-efi@lfdr.de>; Mon,  4 Nov 2019 16:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfKDPSr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 Nov 2019 10:18:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58018 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbfKDPSr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 Nov 2019 10:18:47 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4FCPlL032257;
        Mon, 4 Nov 2019 15:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=wI+MlQfXsMx0uWokWMoST+s/IjPegRzzQjCD9nh+Q+o=;
 b=Y4QNrQVsbZ/BnO04dhmq9gO+33O7WD7A0vrMN69D194HaDfvhyveJxdhBvQRhwKLcNib
 c4NM8JddRmjoeLcyY2S0nAW+ZLf70RNi1rhwnvCH4v8HByMiPEEuc/Iv6XefpjpcCgsM
 HrU4gex/gSamGEpCKjgQtxGqaORbunYDONOCxp8fiPky4MlihpexRRQTnTa+A5rJd8m4
 xcCdhAY8xazJR/xQlraufK2Gfk49rbwdnckKLu3/VX3xg8bBGfVGBLk5GIqCHzE6LU8G
 M6wKMs1Lyf1ZZRcwP4Ao/BB1NdVlXuywgl9WzbfJdO7gY2NPAX3FZz41XpKnKryFvHM9 Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w11rpr20x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 15:18:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4FAASi019949;
        Mon, 4 Nov 2019 15:16:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2w1kxmhnd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 15:16:19 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA4FGGZo019676;
        Mon, 4 Nov 2019 15:16:16 GMT
Received: from tomti.i.net-space.pl (/10.175.168.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 07:16:15 -0800
Date:   Mon, 4 Nov 2019 16:16:09 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        jgross@suse.com, kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, rdunlap@infradead.org, ross.philipson@oracle.com,
        tglx@linutronix.de
Subject: Re: [PATCH v4 2/3] x86/boot: Introduce the kernel_info.setup_type_max
Message-ID: <20191104151609.k4qxlw4sbqvld357@tomti.i.net-space.pl>
References: <20191024114814.6488-1-daniel.kiper@oracle.com>
 <20191024114814.6488-3-daniel.kiper@oracle.com>
 <e094a1cf-6bf2-1e8a-94c7-47767d66138e@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e094a1cf-6bf2-1e8a-94c7-47767d66138e@zytor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=925
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040151
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 01, 2019 at 01:55:57PM -0700, H. Peter Anvin wrote:
> On 2019-10-24 04:48, Daniel Kiper wrote:
> > This field contains maximal allowed type for setup_data.
> >
> > Now bump the setup_header version in arch/x86/boot/header.S.
>
> Please don't bump the protocol revision here, otherwise we would create
> a very odd pseudo-revision of the protocol: 2.15 without SETUP_INDIRECT
> support, should patch 3/3 end up getting reverted.
>
> (It is possible to detect, of course, but I feel pretty sure in saying
> that bootloaders won't get it right.)
>
> Other than that:
>
> Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>

I have just sent v5. Please take a look.

Daniel
