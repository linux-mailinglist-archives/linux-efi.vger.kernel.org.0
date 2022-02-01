Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5ED4A6641
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 21:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiBAUoN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 15:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240341AbiBAUoM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 15:44:12 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDE4C06173E
        for <linux-efi@vger.kernel.org>; Tue,  1 Feb 2022 12:44:11 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p27so36403284lfa.1
        for <linux-efi@vger.kernel.org>; Tue, 01 Feb 2022 12:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ziGDzhe4hiIJbW+habtGmGnhoT35aHsGESQviCaQ+w=;
        b=ULRhHEwfC7PGE+4k1GDiGsO/d2FjnY+Oi4trs0eFA5DaXt/oV+RNNnSbpgrhC6aKbZ
         XJ6govUz89erjGyfE7+7SVOskPe5PMFEu/tDTSBXkiTwqX3Zic6jNWZWMbOeawCw2SYc
         3NKbkGph8POLHTfNE0Y0Zmdw1M0ofWjVr3GPyNPUu1T7FgK+hyJmjRNzjDWi0kuY3VCi
         zobUuDbb3xQKyd9QYUUaM62NkosplK0FoeqV5eeE1wW0dN+fOJVn2J2VozPi6apyaCqZ
         uZBBb+B+pvdCOU/34ZCAt49cKTUpwt4YM3jOVBzXb6mr3YgQnqRUeQyhAPyv849wVQ/i
         NJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ziGDzhe4hiIJbW+habtGmGnhoT35aHsGESQviCaQ+w=;
        b=MkCzJ3WKCXGkpzJWz8E/V/Bq9MDd++om0yogN3eJmAiLi+yKSUc68Kd+1V/dl4DNxM
         g+cDNhWUl3muaCyLYF1tVzW538hQSoii0eFw9/oilkswWGTDuIXumpaCxR9Lgz3JTn97
         jmVvDNp2xOPcuge81yZhA+Rj/ve4hFVoGhjLRN2ecQJcKFA9wgW4zk5OCbLtHEZ7CloC
         q25DtkSaaxhhBOh6pEo7iy/gZhCTNSD0pc4XI+ggNsQiZjemLEqe0dEy5MAsCN/iCWC9
         YAKdfYS5U90C4TChkyJdavN27AqSBafMco9QP+0lmsoITQDgnCteKJZTIAki6QdWbkHQ
         OkNg==
X-Gm-Message-State: AOAM531zSiCP6TuxCaf0XPwNqXj6kGe0o3jY6Ip0MIV+h0S8Z+Sr7uMh
        e5WXlW0vOxbr/rYnpMdY2QB0nv/LQoQMXJLHhG+aYw==
X-Google-Smtp-Source: ABdhPJwu5e/9vy9h+TUoxFYmOE/ShH6BFV+jT8/RYV64qcflT/MzViz3MDcjtuZdgZhQPiMmVonl0lLHMhxVwRqnNjU=
X-Received: by 2002:a05:6512:1520:: with SMTP id bq32mr19454952lfb.644.1643748249618;
 Tue, 01 Feb 2022 12:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20220128171804.569796-1-brijesh.singh@amd.com> <20220128171804.569796-44-brijesh.singh@amd.com>
In-Reply-To: <20220128171804.569796-44-brijesh.singh@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 1 Feb 2022 13:43:57 -0700
Message-ID: <CAMkAt6r_AupKbpmO7twMBtADrMPtWrRJ6kjAT4c1xGrZmUQ7sw@mail.gmail.com>
Subject: Re: [PATCH v9 43/43] virt: sevguest: Add support to get extended report
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, Tony Luck <tony.luck@intel.com>,
        Marc Orr <marcorr@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 10:19 AM Brijesh Singh <brijesh.singh@amd.com> wrote:
>
> Version 2 of GHCB specification defines Non-Automatic-Exit(NAE) to get
> the extended guest report. It is similar to the SNP_GET_REPORT ioctl.
> The main difference is related to the additional data that will be
> returned. The additional data returned is a certificate blob that can
> be used by the SNP guest user. The certificate blob layout is defined
> in the GHCB specification. The driver simply treats the blob as a opaque
> data and copies it to userspace.
>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  Documentation/virt/coco/sevguest.rst  | 23 +++++++
>  drivers/virt/coco/sevguest/sevguest.c | 89 +++++++++++++++++++++++++++
>  include/uapi/linux/sev-guest.h        | 13 ++++
>  3 files changed, 125 insertions(+)
>
> diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
> index aafc9bce9aef..b9fe20e92d06 100644
> --- a/Documentation/virt/coco/sevguest.rst
> +++ b/Documentation/virt/coco/sevguest.rst
> @@ -90,6 +90,29 @@ on the various fields passed in the key derivation request.
>  On success, the snp_derived_key_resp.data contains the derived key value. See
>  the SEV-SNP specification for further details.
>
> +
> +2.3 SNP_GET_EXT_REPORT
> +----------------------
> +:Technology: sev-snp
> +:Type: guest ioctl
> +:Parameters (in/out): struct snp_ext_report_req
> +:Returns (out): struct snp_report_resp on success, -negative on error
> +
> +The SNP_GET_EXT_REPORT ioctl is similar to the SNP_GET_REPORT. The difference is
> +related to the additional certificate data that is returned with the report.
> +The certificate data returned is being provided by the hypervisor through the
> +SNP_SET_EXT_CONFIG.
> +
> +The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command provided by the SEV-SNP
> +firmware to get the attestation report.
> +
> +On success, the snp_ext_report_resp.data will contain the attestation report
> +and snp_ext_report_req.certs_address will contain the certificate blob. If the
> +length of the blob is smaller than expected then snp_ext_report_req.certs_len will
> +be updated with the expected value.
> +
> +See GHCB specification for further detail on how to parse the certificate blob.
> +
>  Reference
>  ---------
>
> diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
> index 4369e55df9a6..a53854353944 100644
> --- a/drivers/virt/coco/sevguest/sevguest.c
> +++ b/drivers/virt/coco/sevguest/sevguest.c
> @@ -41,6 +41,7 @@ struct snp_guest_dev {
>         struct device *dev;
>         struct miscdevice misc;
>
> +       void *certs_data;
>         struct snp_guest_crypto *crypto;
>         struct snp_guest_msg *request, *response;
>         struct snp_secrets_page_layout *layout;
> @@ -434,6 +435,84 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
>         return rc;
>  }
>
> +static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
> +{
> +       struct snp_guest_crypto *crypto = snp_dev->crypto;
> +       struct snp_ext_report_req req = {0};
> +       struct snp_report_resp *resp;
> +       int ret, npages = 0, resp_len;
> +
> +       if (!arg->req_data || !arg->resp_data)
> +               return -EINVAL;
> +
> +       /* Copy the request payload from userspace */
> +       if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> +               return -EFAULT;
> +
> +       if (req.certs_len) {
> +               if (req.certs_len > SEV_FW_BLOB_MAX_SIZE ||
> +                   !IS_ALIGNED(req.certs_len, PAGE_SIZE))
> +                       return -EINVAL;
> +       }
> +
> +       if (req.certs_address && req.certs_len) {
> +               if (!access_ok(req.certs_address, req.certs_len))
> +                       return -EFAULT;
> +
> +               /*
> +                * Initialize the intermediate buffer with all zero's. This buffer

zeros

> +                * is used in the guest request message to get the certs blob from
> +                * the host. If host does not supply any certs in it, then copy
> +                * zeros to indicate that certificate data was not provided.
> +                */
> +               memset(snp_dev->certs_data, 0, req.certs_len);
> +
> +               npages = req.certs_len >> PAGE_SHIFT;
> +       }
> +
> +       /*
> +        * The intermediate response buffer is used while decrypting the
> +        * response payload. Make sure that it has enough space to cover the
> +        * authtag.
> +        */
> +       resp_len = sizeof(resp->data) + crypto->a_len;
> +       resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
> +       if (!resp)
> +               return -ENOMEM;

Can we pull this duplicated code from get_report() into a helper?

> +
> +       snp_dev->input.data_npages = npages;
> +       ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
> +                                  SNP_MSG_REPORT_REQ, &req.data,
> +                                  sizeof(req.data), resp->data, resp_len, &arg->fw_err);
> +
> +       /* If certs length is invalid then copy the returned length */
> +       if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
> +               req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
> +
> +               if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
> +                       ret = -EFAULT;
> +       }
> +
> +       if (ret)
> +               goto e_free;
> +
> +       /* Copy the certificate data blob to userspace */
> +       if (req.certs_address && req.certs_len &&
> +           copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
> +                        req.certs_len)) {
> +               ret = -EFAULT;
> +               goto e_free;
> +       }
> +
> +       /* Copy the response payload to userspace */
> +       if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
> +               ret = -EFAULT;
> +
> +e_free:
> +       kfree(resp);
> +       return ret;
> +}
> +
>  static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
>  {
>         struct snp_guest_dev *snp_dev = to_snp_dev(file);
> @@ -466,6 +545,9 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>         case SNP_GET_DERIVED_KEY:
>                 ret = get_derived_key(snp_dev, &input);
>                 break;
> +       case SNP_GET_EXT_REPORT:
> +               ret = get_ext_report(snp_dev, &input);
> +               break;
>         default:
>                 break;
>         }
> @@ -594,6 +676,10 @@ static int __init snp_guest_probe(struct platform_device *pdev)
>         if (!snp_dev->response)
>                 goto e_fail;
>
> +       snp_dev->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
> +       if (!snp_dev->certs_data)
> +               goto e_fail;
> +
>         ret = -EIO;
>         snp_dev->crypto = init_crypto(snp_dev, snp_dev->vmpck, VMPCK_KEY_LEN);
>         if (!snp_dev->crypto)
> @@ -607,6 +693,7 @@ static int __init snp_guest_probe(struct platform_device *pdev)
>         /* initial the input address for guest request */
>         snp_dev->input.req_gpa = __pa(snp_dev->request);
>         snp_dev->input.resp_gpa = __pa(snp_dev->response);
> +       snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
>
>         ret =  misc_register(misc);
>         if (ret)
> @@ -617,6 +704,7 @@ static int __init snp_guest_probe(struct platform_device *pdev)
>
>  e_fail:
>         iounmap(layout);
> +       free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
>         free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
>         free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
>
> @@ -629,6 +717,7 @@ static int __exit snp_guest_remove(struct platform_device *pdev)
>
>         free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
>         free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
> +       free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
>         deinit_crypto(snp_dev->crypto);
>         misc_deregister(&snp_dev->misc);
>
> diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
> index bcd00a6d4501..0a47b6627c78 100644
> --- a/include/uapi/linux/sev-guest.h
> +++ b/include/uapi/linux/sev-guest.h
> @@ -56,6 +56,16 @@ struct snp_guest_request_ioctl {
>         __u64 fw_err;
>  };
>
> +struct snp_ext_report_req {
> +       struct snp_report_req data;
> +
> +       /* where to copy the certificate blob */
> +       __u64 certs_address;
> +
> +       /* length of the certificate blob */
> +       __u32 certs_len;
> +};
> +
>  #define SNP_GUEST_REQ_IOC_TYPE 'S'
>
>  /* Get SNP attestation report */
> @@ -64,4 +74,7 @@ struct snp_guest_request_ioctl {
>  /* Get a derived key from the root */
>  #define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_guest_request_ioctl)
>
> +/* Get SNP extended report as defined in the GHCB specification version 2. */
> +#define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_guest_request_ioctl)
> +
>  #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
> --
> 2.25.1
>
