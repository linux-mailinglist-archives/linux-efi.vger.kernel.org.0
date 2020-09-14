Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DB02691F6
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 18:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgINQpQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 12:45:16 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:44158 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbgINQpF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Sep 2020 12:45:05 -0400
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08EGdFGk022142;
        Mon, 14 Sep 2020 16:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pps0720; bh=Pm/656QFtJruBAnE4Q3O47Rjukt6SAkxNbJK/aGyHJ4=;
 b=NycJ0xSZ4BEFFf1I9HnQ8ByWlDMHfTrxTjpC5QKldRH8CQxOZq4OrTapdK16Y3Bmgdm3
 aFqV/eMsjTkgGQ8k2dUnO6HCL6KfW+rKM8muftCyHPePXWA7dcegGMPUXTBeEQC5ldaH
 x5GoOqroVacsFU33/0n72iYBSCTLMnB8W9mkKc1WD9aTuZUWuqLUXMQ9/7f6WXhU648Y
 7uuxF9I42a0XvoWofF4DwY1F8LxjgdPcK6NRtga9RC5FPm/yhSB1YauB4keopLNvJ2dj
 KiiysK8qwWbympHr3dC81Z1+AyAR4PvWwoclrminWD752U1Lx0yh7JaM3Afwxren8gJt hw== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 33gqmp90bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 16:44:32 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 6F0C266;
        Mon, 14 Sep 2020 16:44:31 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 9690845;
        Mon, 14 Sep 2020 16:44:30 +0000 (UTC)
Date:   Mon, 14 Sep 2020 11:44:30 -0500
From:   Russ Anderson <rja@hpe.com>
To:     Alex Kluver <kluveralex@gmail.com>
Cc:     linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ardb@kernel.org, mchehab@kernel.org,
        bp@alien8.de, russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        kluveralex@gmail.com
Subject: Re: [PATCH v2 0/2] UEFI v2.8 Memory Error Record Updates
Message-ID: <20200914164348.pfgl3u6l5ijgb2jo@hpe.com>
Reply-To: Russ Anderson <rja@hpe.com>
References: <20200819143544.155096-1-alex.kluver@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819143544.155096-1-alex.kluver@hpe.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-14_06:2020-09-14,2020-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 suspectscore=2 malwarescore=0 bulkscore=0 mlxlogscore=857
 clxscore=1011 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009140134
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 19, 2020 at 09:35:42AM -0500, Alex Kluver wrote:
> The UEFI Specification v2.8, Table 299, Memory Error Record has
> several changes from previous versions. Bits 18 through 21 have been
> added to the memory validation bits to include an extended version
> of row, an option to print bank address and group separately, and chip id.
> These patches implement bits 18 through 21 into the Memory Error Record.
> 
> Change reserved field to extended field in cper_sec_mem_err structure
> and added the extended field to the cper_mem_err_compact structure.
> 
> Print correct versions of row, bank, and chip ID.

Are there any community comment on this patch set?
Questions/comments/concerns?

Thanks.

> ---
> v1 -> v2:
>    * Add static inline cper_get_mem_extension to make
>      it more readable, as suggested by Borislav Petkov
> 
>    * Add second patch for bank field, bank group, and chip id.
> ---
> Alex Kluver (2):
>   edac,ghes,cper: Add Row Extension to Memory Error Record
>   cper,edac,efi: Memory Error Record: bank group/address and chip id
> 
>  drivers/edac/ghes_edac.c    | 17 +++++++++++++++--
>  drivers/firmware/efi/cper.c | 18 ++++++++++++++++--
>  include/linux/cper.h        | 24 ++++++++++++++++++++++--
>  3 files changed, 53 insertions(+), 6 deletions(-)
> 
> -- 
> 2.26.2
> 

-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja@hpe.com
