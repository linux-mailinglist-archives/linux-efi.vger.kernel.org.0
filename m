Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6E0A7759
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2019 00:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfICWzF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Sep 2019 18:55:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbfICWzE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Sep 2019 18:55:04 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x83MqFIQ117194
        for <linux-efi@vger.kernel.org>; Tue, 3 Sep 2019 18:55:03 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usxtw4861-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Tue, 03 Sep 2019 18:55:03 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 3 Sep 2019 23:55:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Sep 2019 23:54:56 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x83MssVe50004060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Sep 2019 22:54:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8319E5204E;
        Tue,  3 Sep 2019 22:54:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.191.35])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8E51452051;
        Tue,  3 Sep 2019 22:54:52 +0000 (GMT)
Subject: Re: [PATCH v3 4/4] powerpc: load firmware trusted keys/hashes into
 kernel keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 03 Sep 2019 18:54:51 -0400
In-Reply-To: <1566825818-9731-5-git-send-email-nayna@linux.ibm.com>
References: <1566825818-9731-1-git-send-email-nayna@linux.ibm.com>
         <1566825818-9731-5-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090322-4275-0000-0000-00000360BA63
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090322-4276-0000-0000-00003872FD9F
Message-Id: <1567551291.4937.8.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909030229
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2019-08-26 at 09:23 -0400, Nayna Jain wrote:
> The keys used to verify the Host OS kernel are managed by firmware as
> secure variables. This patch loads the verification keys into the .platform
> keyring and revocation hashes into .blacklist keyring. This enables
> verification and loading of the kernels signed by the boot time keys which
> are trusted by firmware.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Feel free to add my tag after addressing the formatting issues.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
> new file mode 100644
> index 000000000000..359d5063d4da
> --- /dev/null
> +++ b/security/integrity/platform_certs/load_powerpc.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 IBM Corporation
> + * Author: Nayna Jain <nayna@linux.ibm.com>
> + *
> + *      - loads keys and hashes stored and controlled by the firmware.
> + */
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/cred.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <asm/secboot.h>
> +#include <asm/secvar.h>
> +#include "keyring_handler.h"
> +
> +/*
> + * Get a certificate list blob from the named secure variable.
> + */
> +static __init void *get_cert_list(u8 *key, unsigned long keylen, uint64_t *size)
> +{
> +	int rc;
> +	void *db;
> +
> +	rc = secvar_ops->get(key, keylen, NULL, size);
> +	if (rc) {
> +		pr_err("Couldn't get size: %d\n", rc);
> +		return NULL;
> +	}
> +
> +	db = kmalloc(*size, GFP_KERNEL);
> +	if (!db)
> +		return NULL;
> +
> +	rc = secvar_ops->get(key, keylen, db, size);
> +	if (rc) {
> +		kfree(db);
> +		pr_err("Error reading db var: %d\n", rc);
> +		return NULL;
> +	}
> +
> +	return db;
> +}
> +
> +/*
> + * Load the certs contained in the keys databases into the platform trusted
> + * keyring and the blacklisted X.509 cert SHA256 hashes into the blacklist
> + * keyring.
> + */
> +static int __init load_powerpc_certs(void)
> +{
> +	void *db = NULL, *dbx = NULL;
> +	uint64_t dbsize = 0, dbxsize = 0;
> +	int rc = 0;
> +
> +	if (!secvar_ops)
> +		return -ENODEV;
> +
> +	/* Get db, and dbx.  They might not exist, so it isn't
> +	 * an error if we can't get them.
> +	 */
> +	db = get_cert_list("db", 3, &dbsize);
> +	if (!db) {
> +		pr_err("Couldn't get db list from firmware\n");
> +	} else {
> +		rc = parse_efi_signature_list("powerpc:db",
> +				db, dbsize, get_handler_for_db);
> +		if (rc)
> +			pr_err("Couldn't parse db signatures: %d\n",
> +					rc);

There's no need to split this line.

> +		kfree(db);
> +	}
> +
> +	dbx = get_cert_list("dbx", 3,  &dbxsize);
> +	if (!dbx) {
> +		pr_info("Couldn't get dbx list from firmware\n");
> +	} else {
> +		rc = parse_efi_signature_list("powerpc:dbx",
> +				dbx, dbxsize,
> +				get_handler_for_dbx);

Formatting of this line is off.

> +		if (rc)
> +			pr_err("Couldn't parse dbx signatures: %d\n", rc);
> +		kfree(dbx);
> +	}
> +
> +	return rc;
> +}
> +late_initcall(load_powerpc_certs);

