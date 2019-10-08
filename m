Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50026CF8C8
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2019 13:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfJHLq5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Oct 2019 07:46:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38228 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbfJHLq5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Oct 2019 07:46:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98Bd9DM132304;
        Tue, 8 Oct 2019 11:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=PzmxrTRLPOfP7XbIeOlj3jtYPqIjtHAyOsTpJymwyfM=;
 b=iD4XLUGbH1qsplCHkkPpUMAHG9eaaqqFGuDMDYfqSvIP08kPvTQvx3HlpwLTqJBYMdzY
 trYXOMFenVL3ZstTuSwUCesO4KI9KM5Z3WKTO11aIZSN6CMUJnF6I7tXuSfaSKfeTIce
 vaLQcc1VFrQaVDzqBGzIMOFXu6ji/MsXJ5hD+TTJwFBdkP49K9iVA7FZtMlHDv6aOvBp
 AZOH64SgcykAiBUqWg/T1eF1Gdjeu1ELFiF+IeV4dRAU0SFDoBf45gP5wjPzzldyX+ZT
 a6rlDfXfodeNyCR8754OV41Ml3EtJ0S3GQHgZ2aD1XkLQjhUGusuajSqgB5qPnxRmkbg Qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vejkucscy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 11:46:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98BhSq1017050;
        Tue, 8 Oct 2019 11:46:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vgeuxqpyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 11:46:46 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x98Bki1f024655;
        Tue, 8 Oct 2019 11:46:44 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 04:46:44 -0700
Date:   Tue, 8 Oct 2019 14:46:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] efi/tpm: fix sanity check of unsigned tbl_size
 being less than zero
Message-ID: <20191008114559.GD25098@kadam>
References: <20191008100153.8499-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008100153.8499-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080114
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 08, 2019 at 11:01:53AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the check for tbl_size being less than zero is always false
> because tbl_size is unsigned. Fix this by making it a signed int.
> 
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: e658c82be556 ("efi/tpm: Only set 'efi_tpm_final_log_size' after successful event log parsing")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/firmware/efi/tpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 703469c1ab8e..ebd7977653a8 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -40,7 +40,7 @@ int __init efi_tpm_eventlog_init(void)
>  {
>  	struct linux_efi_tpm_eventlog *log_tbl;
>  	struct efi_tcg2_final_events_table *final_tbl;
> -	unsigned int tbl_size;
> +	int tbl_size;
>  	int ret = 0;


Do we need to do a "ret = tbl_size;"?  Currently we return success.
It's a pitty that tpm2_calc_event_log_size() returns a -1 instead of
-EINVAL.

regards,
dan carpenter

