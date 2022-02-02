Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09B4A6FD0
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 12:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343871AbiBBLT4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 06:19:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230163AbiBBLTx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 06:19:53 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212ABdTh027686;
        Wed, 2 Feb 2022 11:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zF/VgXaD0gD4JIuHivKshypM2GKtvRpbCMzF+nA0xMk=;
 b=QaTHVJyqB9EDfOT69F3TI4nEhR0BgLm+uK6/sNzaBCiHWz98gUrgRVnnKXzenVdsvgV3
 By3JlvJmFnUT6vrNtkzt6nHALgxT3e+wshMp+pYAf702SQDuV3lh2zNg9aNY8JvzltHl
 7epTlSuqxrwD0dSWto50dT1d0f+X1OiB5Nujr8KtQDBnYk3j1ePT4hnzDLMMWmbGF4NM
 BX1j3l9x3aCgqn7fXrdn2mX79MwvW9sTHWHQb9EYYSqaPF2iVAl5NDhi0E4z0Lx6dhFg
 2tWMFaqooSEBvfCFm/G3tFafjUcGh3pMGRnD7HARb0IeEgGlkOgy8KMvA/66Ez3tUu41 uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyr0093xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 11:19:42 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 212BHL4h021836;
        Wed, 2 Feb 2022 11:19:41 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyr0093wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 11:19:41 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 212B9DE5003307;
        Wed, 2 Feb 2022 11:19:38 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 3dvw7b3et2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 11:19:38 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 212BJbCr12386666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Feb 2022 11:19:37 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E78C28058;
        Wed,  2 Feb 2022 11:19:37 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CEDD2806F;
        Wed,  2 Feb 2022 11:19:32 +0000 (GMT)
Received: from [9.65.240.79] (unknown [9.65.240.79])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Feb 2022 11:19:32 +0000 (GMT)
Message-ID: <c70032f6-d0c8-640a-a3d5-5e5214a3d3ac@linux.ibm.com>
Date:   Wed, 2 Feb 2022 13:19:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v7 5/5] docs: security: Add coco/efi_secret documentation
Content-Language: en-US
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <20220201124413.1093099-6-dovmurik@linux.ibm.com>
 <20220202084909.ancetiuel6xysh2q@sirius.home.kraxel.org>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <20220202084909.ancetiuel6xysh2q@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ST5cUzy63YRTS4VkIaJvFDoBEbRvtZce
X-Proofpoint-GUID: onZARKGVxlRgdw35Yjbmc9mdxc6REZJX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_05,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 mlxlogscore=987 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020059
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 02/02/2022 10:49, Gerd Hoffmann wrote:
> On Tue, Feb 01, 2022 at 12:44:13PM +0000, Dov Murik wrote:
>> Add documentation for the efi_secret module which allows access
>> to Confidential Computing injected secrets.
> 
> Looks good, but might need updates when the paths change.
> 
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> 

Thanks for reviewing the series.

-Dov
